#!/usr/bin/R
# --------------------------------------------------------
# Nombre del Script: graficar_pastel.R
# Descripcion: Preparacion de un pastel de cumple
# Autor: hreyes
# Fecha de Creacion: 2023-09-30
# Fuente de Inspiracion: Qiuyu's Blog
# URL de la Fuente: https://qiuyiwu.github.io/2019/01/29/Birthday/
# --------------------------------------------------------
# set up log 
sink(file = snakemake@log[[1]], append = TRUE, type = c("output", "message"), split = TRUE)

# Cargar librerias 
library(lubridate)
library(plotrix)
library(ggplot2)

message("\nLoaded required libraries")

# --------------------------------------------------------
# Parametros del Pastel
# --------------------------------------------------------
# Parametros para el nombre del archivo de salida y el nombre
nombre <- snakemake@params[["nombre"]]
grafica_out <- snakemake@output[[1]]
fecha_de_nacimiento <- snakemake@params[["dob"]] 

# Parametros del pastel
size_pastel <- 10  
color_capa_1 <- "#C0C0C0"  
color_capa_2 <- snakemake@params[["flavor"]]  
color_capa_3 <- snakemake@params[["frosting"]]  

# Parametros de las Velas
velas_posiciones <- matrix(c(2, 4.5, 3, 5, 4, 4.5, 5, 4.5, 6, 4.5, 7, 5.2, 8, 4.8), ncol = 2, byrow = TRUE)
colores_velas <- c("#4EA5D9", "#688E26", "#2274A5", "#F75C03", "#688E26", "#17BEBB", "#224870", "#44CFCB")
altura_velas <- 3.5

message("\nLoaded and created parameters")

# --------------------------------------------------------
# Funcion para determinar si hay cumpleaños
# --------------------------------------------------------
# Obtener la fecha actual
hoy <- lubridate::today()

# homologar los años
x <- gsub(year(fecha_de_nacimiento), year(today()), fecha_de_nacimiento)

if(x == hoy) {
  pastel <- TRUE
  mensaje <- paste0("Hoy es ", format(hoy, "%d/%m/%Y"), " ¡¡Feliz Cumpleaños!!")
  } else if(x >= (hoy - days(3)) & x <= hoy) {
    pastel <- TRUE
    mensaje <- paste0("Hoy es ", format(hoy, "%d/%m/%Y"), "¡¡Acaba de ser tu cumpleaños, felicidades!!")
  } else if(x >= hoy & x <= (hoy + days(3))) {
    pastel <- TRUE
    mensaje <- paste0("Hoy es ", format(hoy, "%d/%m/%Y"), " ¡¡Ya casi es tu cumpleaños, felicidades!!")

  } else {
    pastel <- FALSE
    mensaje <- paste0("Hoy es ", format(hoy, "%d/%m/%Y"), " y no es tu cumpleaños, ", nombre, " :(")
    
    # Cono de helado
    triangulo <- data.frame(x = c(1, 2.5, 4), y = c(4, 0, 4))
    
    # Bolas de helado y cereza
    c1 <- data.frame(x = 1.75, y = 5, radio = 40)
    c2 <- data.frame(x = 3.25, y = 5, radio = 40)
    c3 <- data.frame(x = 2.35, y = 7, radio = 37)
    ce <- data.frame(x = 2.8, y = 8.5, radio = 5)
    
    # Crear helado de consolacion
    helado <- ggplot() +
      geom_polygon(data = triangulo, aes(x = x, y = y), fill = "#D2B48C", color="#8B4513") +
      geom_point(data = c2, aes(x = x, y = y), shape = 16, size = c2$radio * 2, alpha=0.97, colour = "#8B4513") +
      geom_point(data = c1, aes(x = x, y = y), shape = 19, size = c1$radio * 2, alpha=0.98, colour = "pink") +
      geom_point(data = c3, aes(x = x, y = y), shape = 16, size = c3$radio * 2, alpha=0.98, colour = "#FDF5E6") +
      geom_point(data = ce, aes(x = x, y = y), shape = 10, size = ce$radio * 2, colour = "red") +
      xlim(0, 5) + xlab("...pero celebremos el codigo reproducible con un helado Napolitano, yumm") +
      ylim(0, 9) + ylab("") +
      theme_minimal() + ggtitle(mensaje)
  }

message("\nDetermined if today is a birthday")

# --------------------------------------------------------
# Funcion para Dibujar una Vela en la Posicion Especificada
# --------------------------------------------------------
dibujar_vela <- function(pos, color, altura)
{
  x = pos[1]
  y = pos[2]
  
  # Dibujar el cuerpo de la vela como un rectángulo del color especificado
  rect(x, y, x + .2, y + altura, col = color)
  
  # Dibujar la llama de la vela como un polígono amarillo
  llama_x <- c(x + .05, x - .1, x + .1, x + .3, x + .15, x + 0.05)
  llama_y <- c(y + altura, y + altura + 0.3, y + altura + 0.6, y + altura + 0.3, y + altura, y + altura)
  polygon(llama_x, llama_y, col = "#FFD700")
  
  # Dibujar un polígono rojo (flama más pequeña) un poco más abajo que el centro de la llama amarilla
  centro_x <- mean(llama_x)
  centro_y <- mean(llama_y) - 0.35  # Ajustamos la posición vertical aquí
  poligono_rojo_x <- c(centro_x - 0.025, centro_x - 0.05, centro_x + 0.05, centro_x + 0.025)
  poligono_rojo_y <- c(centro_y + 0.15, centro_y + 0.3, centro_y + 0.3, centro_y + 0.15)
  polygon(poligono_rojo_x, poligono_rojo_y, col = "red")
}

# --------------------------------------------------------
# Configurar el plano de dibujo para el pastel de cumpleaños
# --------------------------------------------------------
pdf(grafica_out, width = 8, height = 6)

if(pastel) {
  plot(c(0, size_pastel), c(0, size_pastel), type = "n", bty = "n", xaxt = "n", yaxt = "n", 
       main = paste0("Pastel para ", nombre), xlab = "", ylab = "")
  
  # Dibujar las capas del pastel con los colores definidos
  draw.ellipse(size_pastel / 2, size_pastel / 5, col = color_capa_1, a = size_pastel * 0.44, b = size_pastel * 0.17, border = 1)
  draw.ellipse(size_pastel / 2, size_pastel / 5, col = color_capa_2, a = size_pastel * 0.4, b = size_pastel * 0.14, border = 1)
  rect(size_pastel * 0.1, size_pastel / 5, size_pastel * 0.9, size_pastel / 2, col = color_capa_2, border = color_capa_2)
  lines(c(size_pastel * 0.1, size_pastel * 0.1), c(size_pastel / 5, size_pastel / 2))
  lines(c(size_pastel * 0.9, size_pastel * 0.9), c(size_pastel / 5, size_pastel / 2))
  draw.ellipse(size_pastel / 2, size_pastel / 2, col = color_capa_3, a = size_pastel * 0.4, b = size_pastel * 0.14)
  
  # Dibujar las velas utilizando la función parametrizada y los colores definidos
  for (i in 1:nrow(velas_posiciones)) {
    dibujar_vela(velas_posiciones[i, ], colores_velas[i], altura_velas)
  }
  
  title(sub = mensaje, line = -1)
} else {
  print(helado)
}

dev.off()

message("\nCreated plot to congratulate friend!")

# close log
sink()
