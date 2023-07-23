import tkinter as tk
from tkinter import filedialog as fd
from PIL import ImageTk, Image  
from valuta_qualita_immagine import *

IMMAGINE_APP = None
LABEL_REPORT = []

window = tk.Tk()
window.geometry("1280x720")
window.title("Interfaccia IQA")
window.resizable(0,0)

welcome_label = tk.Label(window,
                         text="Scegli un'immagine di cui valutare la qualità:",
                         font=("Helvetica", 15))
welcome_label.place(x=400, y=0, width=400, height=30)

text_input = tk.Entry()
text_input.place(x=10, y=30, width=1000, height=30)
text_input.configure(state=tk.DISABLED)
  

def scegli_immagine(text_input, window):
    file_path = fd.askopenfilename(filetypes=[("Image File",'.jpg .png .jpeg')])
    
    if(file_path == ''):
        return


    text_input.configure(state=tk.NORMAL)
    text_input.delete(0,"end")
    text_input.insert(0, file_path)
    text_input.configure(state=tk.DISABLED)

    global IMMAGINE_APP
    IMMAGINE_APP = Image.open(file_path)
    resized_image= IMMAGINE_APP.resize((400,600), Image.ANTIALIAS)
    image = ImageTk.PhotoImage(resized_image)  
    image_label = tk.Label(window, image=image)
    image_label.image = image
    image_label.place(x=870, y=70, width=400, height=600)


button_scelta = tk.Button(text="Scegli immagine", command=lambda:scegli_immagine(text_input, window))
button_scelta.place(x=1070, y=30, width=200, height=30)

#### SET DELLE CHECKBOX ####
label_distorsioni = tk.Label(window,
                         text="Scegli le distorsioni da valutare:",
                         font=("Helvetica", 15))
label_distorsioni.place(x=10, y=70, height=30)

speckle_option = tk.BooleanVar()
blur_option = tk.BooleanVar()
black_stains_option = tk.BooleanVar()

checkbutton_speckle = tk.Checkbutton(window, text="Speckle", variable=speckle_option)
checkbutton_blur = tk.Checkbutton(window, text="Gaussian Blur", variable=blur_option)
checkbutton_black_stains = tk.Checkbutton(window, text="Macchie Nere", variable=black_stains_option)

checkbutton_speckle.place(x=10, y=120)
checkbutton_blur.place(x=10, y=150)
checkbutton_black_stains.place(x=10, y=180)

def valuta_qualita():
    if(IMMAGINE_APP == None):
        return
    global LABEL_REPORT
    for label in LABEL_REPORT:
        label.place(x=0, y=0, width=0, height=0)
    LABEL_REPORT = []
    report_qualita = calcola_report_qualita(IMMAGINE_APP, speckle_option.get(), blur_option.get(), black_stains_option.get())
    for i, riga_report in enumerate(report_qualita):
        label_riga_report = tk.Label(window,
                         text=riga_report[0],
                         bg=riga_report[1],
                         font=("Helvetica", 15))
        label_riga_report.place(x=10, y=300 + (30 * i), width=400, height=30)
        LABEL_REPORT.append(label_riga_report)

label_distorsioni.place(x=10, y=70, height=30)

button_valuta_qualita = tk.Button(text="Valuta qualita", command=valuta_qualita)
button_valuta_qualita.place(x=10, y=220, width=400, height=30)


if __name__ == "__main__":
    window.mainloop()