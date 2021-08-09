
KNOWN_TARGETS := CoqMakefile
KNOWN_FILES := Makefile _CoqProject

.DEFAULT: invoke-coqmakefile
.PHONY: invoke-coqmakefile $(KNOWN_FILES)

invoke-coqmakefile: CoqMakefile
	$(MAKE) --no-print-directory -f CoqMakefile $(filter-out $(KNOWN_TARGETS),$(MAKECMDGOALS))

CoqMakefile: Makefile _CoqProject
	$(COQBIN)coq_makefile -f _CoqProject -o CoqMakefile

%: invoke-coqmakefile; @:
