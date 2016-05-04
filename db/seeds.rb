Admin.create!(email: 'daniognr@hotmail.com', profile: 'administrator', password: '12345678')

AvailableCharacteristic.create!([
  {title: "Agua corriente", group: 0, options: nil},
  {title: "Desagüe cloacal", group: 0, options: nil},
  {title: "Teléfono", group: 0, options: nil},
  {title: "Pavimento", group: 0, options: nil},
  {title: "Video cable", group: 0, options: nil},
  {title: "Internet", group: 0, options: nil},
  {title: "Luz", group: 0, options: nil},
  {title: "Gas natural", group: 0, options: nil},
  {title: "Disposición", group: 1, options: "[\"Frente\", \"Contrafrente\", \"Interno\", \"Lateral\"]"},
  {title: "Tipo de portón", group: 1, options: "[\"Corredizo\", \"Levadizo\"]"},
  {title: "F.O.T.", group: 1, options: "{\"type\": \"integer\"}"},
  {title: "Etapa", group: 1, options: "[\"En pozo\", \"En construcción\", \"Terminado\"]"},
  {title: "Ofrece financiación", group: 1, options: nil},
  {title: "Orientación", group: 1, options: "[\"N\", \"S\", \"E\", \"O\", \"NE\", \"NO\", \"SE\", \"SO\"]"},
  {title: "Tipo techo", group: 1, options: "[\"Chapa\", \"Losa\", \"Pizarra\", \"Teja\"]"},
  {title: "Cantidad pisos en edificio", group: 1, options: "{\"type\": \"integer\"}"},
  {title: "Superficie del terreno (m2)", group: 1, options: "{\"type\": \"integer\"}"},
  {title: "Largo del terreno (mts)", group: 1, options: "{\"type\": \"integer\"}"},
  {title: "Frente del terreno (mts)", group: 1, options: "{\"type\": \"integer\"}"},
  {title: "Altura del techo (mts)", group: 1, options: "{\"type\": \"integer\"}"},
  {title: "Cantidad dormitorios", group: 1, options: "{\"type\": \"integer\"}"},
  {title: "Cantidad de pisos en edificio", group: 1, options: "{\"type\": \"integer\"}"},
  {title: "Departamentos por piso", group: 1, options: "{\"type\": \"integer\"}"},
  {title: "Uso comercial", group: 1, options: nil},
  {title: "Estado del edificio", group: 1, options: "[\"Reciclado\", \"Excelente\", \"Muy bueno\", \"Bueno\", \"Regular\", \"A refaccionar\"]"},
  {title: "Apto profesional", group: 1, options: nil},
  {title: "Tipo edificio", group: 1, options: "[\"Entre medianeras\", \"Torre\", \"Tipo block\", \"Esquina\", \"Antiguo\", \"Inteligente\", \"Primera categoría\", \"Estándar\"]"},
  {title: "Luminosidad", group: 1, options: "[\"Muy luminoso\", \"Luminoso\", \"Poco luminoso\"]"},
  {title: "Permite mascotas", group: 1, options: nil},
  {title: "Apto crédito", group: 1, options: nil},
  {title: "Estado del inmueble", group: 1, options: "[\"Reciclado\", \"Excelente\", \"Muy bueno\", \"Bueno\", \"Regular\", \"A refaccionar\"]"},
  {title: "Cobertura cochera", group: 1, options: "[\"Cubierta\", \"Semicubierta\", \"Descubierta\"]"},
  {title: "Cantidad de ascensores", group: 1, options: "{\"type\": \"integer\"}"},
  {title: "Cantidad de plantas", group: 1, options: "{\"type\": \"integer\"}"},
  {title: "Cantidad plantas", group: 1, options: "{\"type\": \"integer\"}"},
  {title: "Cantidad de naves", group: 1, options: "{\"type\": \"integer\"}"},
  {title: "Categoría del edificio", group: 1, options: "[\"Excelente\", \"Muy buena\", \"Buena\", \"Estándar\", \"Económica\", \"Precaria\"]"},
  {title: "Jardín", group: 2, options: nil},
  {title: "Vestidor", group: 2, options: nil},
  {title: "Dormitorio en suite", group: 2, options: nil},
  {title: "Altillo", group: 2, options: nil},
  {title: "Dependencia servicio", group: 2, options: nil},
  {title: "Comedor", group: 2, options: nil},
  {title: "Toilette", group: 2, options: nil},
  {title: "Balcón", group: 2, options: nil},
  {title: "Cocina", group: 2, options: nil},
  {title: "Living", group: 2, options: nil},
  {title: "Comedor de diario", group: 2, options: nil},
  {title: "Lavadero", group: 2, options: nil},
  {title: "Patio", group: 2, options: nil},
  {title: "Hall", group: 2, options: nil},
  {title: "Baulera", group: 2, options: nil},
  {title: "Sótano", group: 2, options: nil},
  {title: "Escritorio", group: 2, options: nil},
  {title: "Living comedor", group: 2, options: nil},
  {title: "Terraza", group: 2, options: nil},
  {title: "Vigilancia", group: 3, options: nil},
  {title: "Amoblado", group: 3, options: nil},
  {title: "Parrilla", group: 3, options: nil},
  {title: "Gimnasio", group: 3, options: nil},
  {title: "Cancha deportes", group: 3, options: nil},
  {title: "Laundry", group: 3, options: nil},
  {title: "Hidromasaje", group: 3, options: nil},
  {title: "Sauna", group: 3, options: nil},
  {title: "Calefacción", group: 3, options: nil},
  {title: "Solarium", group: 3, options: nil},
  {title: "Quincho", group: 3, options: nil},
  {title: "SUM", group: 3, options: nil},
  {title: "Aire acondicionado", group: 3, options: nil},
  {title: "Piscina", group: 3, options: nil},
  {title: "Alarma", group: 3, options: nil},
  {title: "Sala de juegos", group: 3, options: nil}
])
Characteristic.create!([
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 1, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 2, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 3, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 4, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 5, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 6, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 7, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 8, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 12, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 13, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 14, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 15, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 17, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 18, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 19, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 21, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 24, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 28, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 29, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 30, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 31, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 32, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 35, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 38, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 39, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 40, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 41, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 42, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 43, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 44, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 45, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 46, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 47, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 48, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 49, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 50, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 51, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 52, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 53, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 54, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 55, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 56, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 57, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 58, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 59, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 60, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 61, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 64, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 65, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 66, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 67, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 68, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 69, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 70, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 71, option_value: nil},
  {classifiable_id: 1, classifiable_type: "PropertyType", available_characteristic_id: 72, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 1, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 2, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 3, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 4, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 5, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 6, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 7, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 8, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 9, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 12, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 13, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 14, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 16, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 17, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 21, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 23, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 24, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 25, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 26, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 27, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 28, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 29, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 30, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 31, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 32, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 33, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 37, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 38, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 39, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 40, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 41, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 42, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 43, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 44, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 45, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 46, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 47, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 48, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 49, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 50, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 51, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 52, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 53, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 54, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 55, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 56, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 57, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 58, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 59, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 60, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 61, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 62, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 63, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 64, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 65, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 66, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 67, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 68, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 69, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 70, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 71, option_value: nil},
  {classifiable_id: 2, classifiable_type: "PropertyType", available_characteristic_id: 72, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 1, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 2, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 3, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 4, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 5, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 6, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 7, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 8, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 9, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 12, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 13, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 14, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 16, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 21, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 23, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 24, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 25, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 26, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 27, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 28, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 29, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 30, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 31, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 32, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 37, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 38, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 39, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 40, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 42, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 43, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 44, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 45, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 46, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 47, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 48, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 49, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 50, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 51, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 52, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 54, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 55, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 56, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 57, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 58, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 59, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 60, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 61, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 62, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 63, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 64, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 65, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 66, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 67, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 68, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 69, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 70, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 71, option_value: nil},
  {classifiable_id: 3, classifiable_type: "PropertyType", available_characteristic_id: 72, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 1, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 2, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 3, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 4, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 5, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 6, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 7, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 8, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 9, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 12, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 13, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 14, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 16, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 21, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 23, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 24, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 25, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 26, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 27, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 28, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 29, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 30, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 31, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 32, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 37, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 38, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 39, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 40, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 42, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 43, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 44, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 45, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 46, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 47, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 48, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 49, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 50, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 51, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 52, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 54, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 55, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 56, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 57, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 58, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 59, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 60, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 61, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 62, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 63, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 64, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 65, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 66, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 67, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 68, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 69, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 70, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 71, option_value: nil},
  {classifiable_id: 4, classifiable_type: "PropertyType", available_characteristic_id: 72, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 1, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 2, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 3, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 4, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 5, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 6, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 7, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 8, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 9, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 12, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 13, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 14, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 28, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 30, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 31, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 32, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 39, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 44, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 46, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 48, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 52, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 53, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 57, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 58, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 65, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 69, option_value: nil},
  {classifiable_id: 5, classifiable_type: "PropertyType", available_characteristic_id: 71, option_value: nil},
  {classifiable_id: 6, classifiable_type: "PropertyType", available_characteristic_id: 13, option_value: nil},
  {classifiable_id: 6, classifiable_type: "PropertyType", available_characteristic_id: 30, option_value: nil},
  {classifiable_id: 6, classifiable_type: "PropertyType", available_characteristic_id: 32, option_value: nil},
  {classifiable_id: 6, classifiable_type: "PropertyType", available_characteristic_id: 57, option_value: nil},
  {classifiable_id: 7, classifiable_type: "PropertyType", available_characteristic_id: 4, option_value: nil},
  {classifiable_id: 7, classifiable_type: "PropertyType", available_characteristic_id: 7, option_value: nil},
  {classifiable_id: 7, classifiable_type: "PropertyType", available_characteristic_id: 13, option_value: nil},
  {classifiable_id: 7, classifiable_type: "PropertyType", available_characteristic_id: 17, option_value: nil},
  {classifiable_id: 7, classifiable_type: "PropertyType", available_characteristic_id: 18, option_value: nil},
  {classifiable_id: 7, classifiable_type: "PropertyType", available_characteristic_id: 19, option_value: nil},
  {classifiable_id: 7, classifiable_type: "PropertyType", available_characteristic_id: 24, option_value: nil},
  {classifiable_id: 7, classifiable_type: "PropertyType", available_characteristic_id: 30, option_value: nil}
])
PropertyType.create!([
  {name: "Casa", title: "casa"},
  {name: "Departamento", title: "departamento"},
  {name: "PH", title: "ph"},
  {name: "Oficina", title: "oficina"},
  {name: "Local Comercial", title: "local"},
  {name: "Cochera", title: "cochera"},
  {name: "Terreno", title: "terreno"}
])
Zone.create!([
  {name: "Almagro"},
  {name: "Balvanera"},
  {name: "Agronomía"},
  {name: "Barracas"},
  {name: "Belgrano"},
  {name: "Boedo"},
  {name: "Caballito"},
  {name: "Chacarita"},
  {name: "Coghlan"},
  {name: "Colegiales"},
  {name: "Constitución"},
  {name: "Flores"},
  {name: "Floresta"},
  {name: "La Boca"},
  {name: "La Paternal"},
  {name: "Liniers"},
  {name: "Mataderos"},
  {name: "Monte Castro"},
  {name: "Montserrat"},
  {name: "Nueva Pompeya"},
  {name: "Nuñez"},
  {name: "Palermo"},
  {name: "Parque Avellaneda"},
  {name: "Parque Chacabuco"},
  {name: "Parque Patricios"},
  {name: "Puerto Madero"},
  {name: "Recoleta"},
  {name: "Retiro"},
  {name: "Saavedra"},
  {name: "San Cristóbal"},
  {name: "San Nicolás"},
  {name: "San Telmo"},
  {name: "Vélez Sarsfield"},
  {name: "Versalles"},
  {name: "Villa Crespo"},
  {name: "Villa del Parque"},
  {name: "Villa Devoto"},
  {name: "Villa Luro"},
  {name: "Villa General Mitre"},
  {name: "Villa Lugano"},
  {name: "Villa Ortúzar"},
  {name: "Villa Pueyrredón"},
  {name: "Villa Real"},
  {name: "Villa Riachuelo"},
  {name: "Villa Santa Rita"},
  {name: "Villa Soldati"},
  {name: "Villa Urquiza"}
])
