.PHONY: design
design: clean
	touch design/build/THREAD_TABLE.csv
	cat design/data/BSPP_thread.csv | awk -f design/scripts/BSPP_thread.awk >> design/build/THREAD_TABLE.csv
	cat design/data/metric_thread.csv | awk -f design/scripts/metric_thread.awk >> design/build/THREAD_TABLE.csv
	cat design/data/PCO_thread.csv | awk -f design/scripts/PCO_thread.awk >> design/build/THREAD_TABLE.csv
	cat design/data/UIS_thread.csv | awk -f design/scripts/UIS_thread.awk >> design/build/THREAD_TABLE.csv
	cat design/data/microscope_thread.csv | awk -f design/scripts/microscope_thread.awk >> design/build/THREAD_TABLE.csv
	cat design/data/din168k_thread.csv | awk -f design/scripts/din168k_thread.awk >> design/build/THREAD_TABLE.csv
	cat design/build/THREAD_TABLE.csv | awk -f design/scripts/autogenerate.awk > src/THREAD_TABLE.scad

.PHONY: test
test:
	@$(MAKE) -C tests

.PHONY: clean
clean:
	rm -f src/THREAD_TABLE.scad
	rm -f design/build/THREAD_TABLE.csv
	rm -f docs/img_prep/*.png

.PHONY: img_prep
img_prep:
	@$(MAKE) -C docs/img_prep
