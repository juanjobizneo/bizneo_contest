#!/usr/bin/python
# -*- encoding: utf-8 -*-

import time

# Carga de los ficheros de configuración
from selenium import webdriver
baseurl = 'https://www.change.org/p/proh%C3%ADban-las-p%C3%A1ginas-pro-anorexia-y-pro-bulimia-en-internet'

# Iniciamos selenium
mydriver = webdriver.Firefox()
mydriver.maximize_window()

for i in range(0, 100):
  # Acceso a la página
  mydriver.get(baseurl)

  # Click en el botón de inscripción
  button = mydriver.find_element_by_css_selector('.js-sign-button')
  button.click()

  # Se rellenan los campos nombre, apellidos y código postal
  text_inputs = mydriver.find_elements_by_css_selector("input[type='text']")
  for text_input in text_inputs:
    if text_input.get_attribute("placeholder") == "Nombre":
      text_input.send_keys('Mi nombre')
    elif text_input.get_attribute("placeholder") == "Apellidos":
      text_input.send_keys('Mis apellidos')
    elif text_input.get_attribute("name") == "postal_code":
      text_input.send_keys('13005')

  # Se rellena el campo e-mail. Cada iteración proporciona un e-mail diferente
  email_input = mydriver.find_element_by_css_selector("input[type='email']")
  email_input.send_keys("mi_email_python" + str(i) + "@miemail.es")

  # Click en el botón de finalización
  button = mydriver.find_element_by_css_selector('.js-sign-button')
  button.click()

  # Se cierra sesión
  time.sleep(5)
  dropdown = mydriver.find_element_by_css_selector('.dropdown a')
  dropdown.click()

  dropdown_menu = mydriver.find_element_by_css_selector('.dropdown-menu')
  li = dropdown_menu.find_elements_by_css_selector('li')[3]
  sign_out = li.find_element_by_css_selector('a')
  sign_out.click()
  time.sleep(5)
