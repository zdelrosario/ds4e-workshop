
build:
	cd ds4e/notebooks; make
	jb build ds4e

package:
	cd ds4e/notebooks; make
	mkdir -p exercises
	mkdir -p exercises/notebooks
	mkdir -p exercises/notebooks/data
	touch exercises/notebooks/data/.gitignore
	mkdir -p exercises/images
	cp -fr ds4e/notebooks/*assignment.ipynb exercises/notebooks/.
	cp -fr ds4e/notebooks/check_install.ipynb exercises/.
	cp -fr ds4e/images exercises/.
	cp -fr requirements.txt exercises/.

zip: package
	zip -r exercises.zip exercises
	rm -r exercises

open:
	open ds4e/_build/html/index.html

links:
	# Bibtex database
	cp -rf ~/Git/zachs_macros/pubs.bib bibtex_database.bib

dkbuild: package
	docker build -t ds4e .
	rm -r exercises

dkrun:
	docker run -p 10000:8888 f727fc2ff263

clean:
	jb clean .
	cd ds4e/notebooks; make clean
