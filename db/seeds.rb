# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Producto.create([
                  { sku: 5, nombre: 'Yogur', precio: 600, categoria: 'Leche y Derivados', tipo: 'Finished Goods' },
                  { sku: 26, nombre: 'Sal', precio: 1946, categoria: 'Mineral', tipo: 'Raw Material' },
                  { sku: 27, nombre: 'Levadura', precio: 631, categoria: 'Otros', tipo: 'Raw Material' },
                  { sku: 28, nombre: 'Tela de Lino', precio: 1069, categoria: 'Telas', tipo: 'Finished Goods' },
                  { sku: 29, nombre: 'Tela de Lana', precio: 3988, categoria: 'Telas', tipo: 'Finished Goods' },
                  { sku: 30, nombre: 'Tela de Algodón', precio: 1390, categoria: 'Telas', tipo: 'Finished Goods' },
                  { sku: 44, nombre: 'Agave', precio: 3043, categoria: 'Otros', tipo: 'Raw Material' }
])
