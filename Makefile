EXEC=pakowoo
DB=pakowoo

.PHONY: pakowoo
pakowoo:
	go build -o build/bin/${EXEC} src/*.go

.PHONY: database
database:
	sqlite3 ${DB}.db < init/schema.sql
