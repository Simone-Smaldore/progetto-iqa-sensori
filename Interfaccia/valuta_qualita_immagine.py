from tensorflow import keras
import numpy as np

# PATH_MODELLO_SPECKLE = '/Users/simone/Documents/Universita/Sensori/IQA-PROGETTO-GIT/Utilità python/Modelli-v2/modello_pesi_inizializzati_speckle'
# PATH_MODELLO_BLUR = '/Users/simone/Documents/Universita/Sensori/IQA-PROGETTO-GIT/Utilità python/Modelli-v2/modello_pesi_inizializzati_gaussian_blur'
# PATH_MODELLO_BLACK_STAINS = '/Users/simone/Documents/Universita/Sensori/IQA-PROGETTO-GIT/Utilità python/Modelli-v2/modello_pesi_inizializzati_black_stains'

PATH_MODELLO_SPECKLE = '/Users/simone/Documents/Universita/Sensori/IQA-PROGETTO-GIT/Utilità python/Modelli-v2/modello_finale_riaddestrato_speckle'
PATH_MODELLO_BLUR = '/Users/simone/Documents/Universita/Sensori/IQA-PROGETTO-GIT/Utilità python/Modelli-v2/modello_finale_riaddestrato_gaussian_blur'
PATH_MODELLO_BLACK_STAINS = '/Users/simone/Documents/Universita/Sensori/IQA-PROGETTO-GIT/Utilità python/Modelli-v2/modello_finale_riaddestrato_black_stains'

PATH_CLASSIFICATORE_BLUR = '/Users/simone/Documents/Universita/Sensori/IQA-PROGETTO-GIT/Utilità python/classificatori/modelli_classificatori/classificatore_blur'
PATH_CLASSIFICATORE_BLACK_STAINS = '/Users/simone/Documents/Universita/Sensori/IQA-PROGETTO-GIT/Utilità python/classificatori/modelli_classificatori/classificatore_black_stains'

SOGLIA_SPECKLE = 30
SOGLIA_BLUR = 30
SOGLIA_BLACK_STAINS = 80

#TODO Utilizzare i tre modelli per capire se l'immagine è di qualità e il modello più i classificatori per capire il problema


speckle_model = keras.models.load_model(PATH_MODELLO_SPECKLE)
blur_model = keras.models.load_model(PATH_MODELLO_BLUR)
black_stains_model = keras.models.load_model(PATH_MODELLO_BLACK_STAINS)

classificatore_blur = keras.models.load_model(PATH_CLASSIFICATORE_BLUR)
classificatore_black_stains = keras.models.load_model(PATH_CLASSIFICATORE_BLACK_STAINS)

HEIGHT = 512
WIDTH = 512
TARGET_SIZE = (WIDTH, HEIGHT)

def calcola_report_qualita(image, blur, black_stains):
    qualita_speckle, qualita_blur, qualita_black_stains, classe_blur, classe_black_stains = _qualita_etichette_da_immagine(image)

    print(f'Etichetta qualità speckle: {qualita_speckle}')
    print(f'Etichetta qualità blur: {qualita_blur}')
    print(f'Etichetta qualità black stains: {qualita_black_stains}')
    print(f'Classe blur: {classe_blur}')
    print(f'Classe classe_black_stains {classe_black_stains}')

    report = []
    report = _aggiungi_righe_report(report, blur, classe_blur,  'blur')
    report = _aggiungi_righe_report(report, black_stains, classe_black_stains,'macchie nere')

    if(classe_blur == 1 or classe_black_stains == 1 or qualita_speckle < 30 or qualita_blur < 30 or qualita_black_stains< 30):
        report.append((f'L\'immagine ha dei problemi', 'red'))
    return report

def _aggiungi_righe_report(report, usa_qualita, classe, distorsione):
    if(not usa_qualita):
        return report
    if(classe == 1):
        report.append((f'L\'immagine ha problemi di {distorsione}', 'red'))
        return report
    report.append((f'L\'immagine non ha problemi di {distorsione}', 'green'))
    return report

def _qualita_etichette_da_immagine(image):
    resized_image = image.resize(TARGET_SIZE)
    image_array = np.array(resized_image)
    normalized_image_array = image_array / 255.0
    
    qualita_speckle = speckle_model.predict(np.array([normalized_image_array]))
    qualita_blur = blur_model.predict(np.array([normalized_image_array]))
    qualita_black_stains = black_stains_model.predict(np.array([normalized_image_array]))
    classe_blur = classificatore_blur.predict(np.array([normalized_image_array]))
    classe_blur = 0 if classe_blur <= 0.99 else 1
    classe_black_stains = classificatore_black_stains.predict(np.array([normalized_image_array]))
    classe_black_stains = 0 if classe_black_stains <= 0.99 else 1
    return qualita_speckle, qualita_blur, qualita_black_stains, classe_blur, classe_black_stains