from tensorflow import keras
import numpy as np

PATH_MODELLO_SPECKLE = '/Users/simone/Documents/Universita/Sensori/IQA-PROGETTO-GIT/Utilità python/Modelli/modello_finale_riaddestrato_v3'
PATH_MODELLO_BLUR = '/Users/simone/Documents/Universita/Sensori/IQA-PROGETTO-GIT/Utilità python/Modelli/modello_finale_riaddestrato_v3'
PATH_MODELLO_BLACK_STAINS = '/Users/simone/Documents/Universita/Sensori/IQA-PROGETTO-GIT/Utilità python/Modelli/modello_finale_riaddestrato_v3'

SOGLIA_SPECKLE = 30
SOGLIA_BLUR = 30
SOGLIA_BLACK_STAINS = 30

speckle_model = keras.models.load_model(PATH_MODELLO_SPECKLE)
blur_model = keras.models.load_model(PATH_MODELLO_BLUR)
black_stains_model = keras.models.load_model(PATH_MODELLO_BLACK_STAINS)

HEIGHT = 512
WIDTH = 512
TARGET_SIZE = (WIDTH, HEIGHT)

def calcola_report_qualita(image, speckle, blur, black_stains):
    qualita_speckle, qualita_blur, qualita_black_stains = _qualita_etichette_da_immagine(image)
    print(f'Etichetta qualità speckle: {qualita_speckle}')
    print(f'Etichetta qualità blur: {qualita_blur}')
    print(f'Etichetta qualità black stains: {qualita_black_stains}')

    report = []
    report = _aggiungi_righe_report(report, speckle, qualita_speckle, SOGLIA_SPECKLE, 'speckle')
    report = _aggiungi_righe_report(report, blur, qualita_blur, SOGLIA_BLUR, 'blur')
    report = _aggiungi_righe_report(report, black_stains, qualita_black_stains, SOGLIA_BLACK_STAINS, 'macchie nere')
    return report

def _aggiungi_righe_report(report, usa_qualita, qualita, soglia, distorsione):
    if(not usa_qualita):
        return report
    if(qualita < soglia):
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

    return qualita_speckle, qualita_blur, qualita_black_stains