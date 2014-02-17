# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Fertilizer.delete_all()
Fertilizer.create(name: 'F1', n_total: 46, n_nh4: 46, n_no3: 0, p2o5: 0, k20: 0, cao: 0, s: 0, mgo: 0, b: 0, zn: 0, na: 0)
Fertilizer.create(name: 'F2', n_total: 16, n_nh4: 0, n_no3: 16, p2o5: 0, k20: 0.5, cao: 0, s: 0.1, mgo: 0.2, b: 0, zn: 0, na: 26)
Fertilizer.create(name: 'F3', n_total: 15, n_nh4: 0, n_no3: 15, p2o5: 0, k20: 14, cao: 0, s: 0.1, mgo: 0.2, b: 0, zn: 0, na: 18)
Fertilizer.create(name: 'F4', n_total: 27, n_nh4: 13.3, n_no3: 13.7, p2o5: 0, k20: 0, cao: 7, s: 0, mgo: 5, b: 0, zn: 0, na: 0)
Fertilizer.create(name: 'F5', n_total: 15.5, n_nh4: 1.1, n_no3: 14.4, p2o5: 0, k20: 0, cao: 26.5, s: 0, mgo: 0, b: 0, zn: 0, na: 0)
Fertilizer.create(name: 'F6', n_total: 0, n_nh4: 0, n_no3: 0, p2o5: 46, k20: 0, cao: 21, s: 1, mgo: 0, b: 0, zn: 0, na: 0)
Fertilizer.create(name: 'F7', n_total: 11, n_nh4: 11, n_no3: 0, p2o5: 52, k20: 0, cao: 2.4, s: 2, mgo: 0.1, b: 0, zn: 0, na: 0)
Fertilizer.create(name: 'F8', n_total: 18, n_nh4: 18, n_no3: 0, p2o5: 46, k20: 0, cao: 1, s: 0, mgo: 0.7, b: 0, zn: 0, na: 0)
Fertilizer.create(name: 'F9', n_total: 13.5, n_nh4: 0, n_no3: 13.5, p2o5: 0, k20: 45, cao: 0, s: 0, mgo: 0, b: 0, zn: 0, na: 0)
Fertilizer.create(name: 'F10', n_total: 0, n_nh4: 0, n_no3: 0, p2o5: 0, k20: 60, cao: 0, s: 0, mgo: 0, b: 0, zn: 0, na: 0)
Fertilizer.create(name: 'F11', n_total: 0, n_nh4: 0, n_no3: 0, p2o5: 0, k20: 50, cao: 0, s: 18, mgo: 0, b: 0, zn: 0, na: 0)
Fertilizer.create(name: 'F12', n_total: 0, n_nh4: 0, n_no3: 0, p2o5: 0, k20: 22, cao: 0, s: 22, mgo: 18, b: 0, zn: 0, na: 0)
Fertilizer.create(name: 'F13', n_total: 0, n_nh4: 0, n_no3: 0, p2o5: 0, k20: 0, cao: 0, s: 20, mgo: 25, b: 0, zn: 0, na: 0)
Fertilizer.create(name: 'F14', n_total: 0, n_nh4: 0, n_no3: 0, p2o5: 0, k20: 0, cao: 0, s: 0, mgo: 94, b: 0, zn: 0, na: 0)
Fertilizer.create(name: 'F15', n_total: 0, n_nh4: 0, n_no3: 0, p2o5: 0, k20: 0, cao: 0, s: 11, mgo: 0, b: 0, zn: 30, na: 0)
Fertilizer.create(name: 'F16', n_total: 0, n_nh4: 0, n_no3: 0, p2o5: 0, k20: 0, cao: 11, s: 0, mgo: 0, b: 10, zn: 0, na: 0)
Fertilizer.create(name: 'F17', n_total: 0, n_nh4: 0, n_no3: 0, p2o5: 0, k20: 0, cao: 0, s: 0, mgo: 4, b: 8, zn: 0, na: 0)

Role.delete_all()
Role.create(name: 'Nuevo', activated: true)

Instance.delete_all()

Company.delete_all()
Company.create(id: 1, name: 'Test')