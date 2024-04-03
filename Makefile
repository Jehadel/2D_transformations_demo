run:
	love src/

love:
	mkdir -p dist
	cd src && zip -r ../dist/2D-transformations.love .

js: love
	love.js -c --title="2D transformations demo with 2x2 matrices" ./dist/2D-transformations.love ./dist/js
