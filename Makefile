.PHONY: clean local all copies converts

all: index2.html index.html

index.html: index-ref.adoc Makefile imgs/*
	asciidoctor -b html5 -T ~/code/ascreveal/templates/slim index-ref.adoc -o index.html

index2.html: index-ref.adoc Makefile imgs/*
	asciidoctor -b html5 index-ref.adoc -o index2.html
	
index-ref.adoc: index.adoc thesis.bib
	asciidoc-bib -b thesis.bib -s "american-physics-society" --numeric-appearance-order index.adoc

thesis.bib: ~/work/papers/thesis/thesis.bib ~/work/papers/thesis/idps.bib
	cp ~/work/papers/thesis/thesis.bib .

imgs/%_converted.svg: ~/work/papers/thesis/imgs/%.pdf
	inkscape --without-gui --file=$<  --export-plain-svg=$@
	
imgs/%_idpconvert.svg: ~/work/idp/imgs/%.pdf
	inkscape --without-gui --file=$<  --export-plain-svg=$@
	
imgs/%_idpconverteps.svg: ~/work/idp/imgs/%.eps
	inkscape --without-gui --file=$<  --export-plain-svg=$@

converts: imgs/aS-AA-visual_converted.svg imgs/aS-UA-visual_converted.svg imgs/aS-CG-visual_converted.svg imgs/Rg-from-exp-2_idpconvert.svg imgs/ramachandranAA_converted.svg imgs/rama09_converted.svg imgs/Rg_vs_alpha_converted.svg imgs/rama-Dunbrack-scatter_idpconvert.svg imgs/Rij-means_idpconverteps.svg imgs/qvh_converted.svg imgs/hydromodels_converted.svg imgs/hphobscales_converted.svg imgs/smFRET_4idps_converted.svg imgs/smFRET-tau_converted.svg imgs/rgs_idps_converted.svg imgs/CG-Rg-scaling-IDPdist_converted.svg

copies: Makefile converts thesis.bib madeimgs/* | imgs
	cp -uv ~/work/slides/cells/150521/imgs/janus-h202-traj.png imgs/
	cp -uv ~/work/slides/cells/150521/imgs/f62_r{0,20}.mp4 imgs/
	cp -uv ~/work/cells/imgs/randkick4H-MSD-cut-f0.5-R20-N40-e10.svg imgs/
	cp -uv ~/work/cells/imgs/randkick4H-MSD-cut-f0.63-R20-N40-e1000.svg imgs/
	cp -uv ~/work/slides/cells/active-matter/imgs/randkick4H-MSD-cut-f0.63-R20-N40-e1000_cut.svg imgs/
	cp -uv ~/work/cells/imgs/randkick4H-MSD-cut-f0.63-R200-N40-e1000.svg imgs/
	cp -uv ~/work/idp/imgs/AA-tricolor-{1,2,3,4}.png imgs/
	cp -uv ~/work/idp/imgs/aS-P-of-Rg-Dedmon-2004.png imgs/
	cp -uv ~/work/idp/imgs/smfret_curve3.gif imgs/
	cp -uv ~/work/idp/imgs/{LJ-repulsive,LJ-attract,ES-potential}-new.svg imgs/
	cp -uv ~/work/idp/imgs/figs.mp4 imgs/idps_UA.mp4
	
	cp -uv ~/work/idp/imgs/aS-Pairs-{54-72,72-92,9-33,54-92,92-130,33-72,9-54,72-130,9-72,54-130,33-130,9-130}.png imgs/
	
	cp -uv ~/work/papers/thesis/imgs/n600_r1.3_m0.1_s9_P1e-6.png imgs/
	cp -uv ~/work/papers/thesis/imgs/n600_r1.6_m0.27_s22_P1e-6.png imgs/
	cp -uv ~/work/papers/thesis/imgs/n600_r2_m0.12_s26_P1e-6.png imgs/
	cp -uv ~/work/papers/thesis/imgs/n600_r5_m0.1_s121_P1e-6.png imgs/
	cp -uv ~/work/papers/thesis/imgs/n600_r5_m0.27_s62_P1e-6.png imgs/
	cp -uv ~/work/papers/thesis/imgs/n600_r5_m0.4_s128_P1e-6.png imgs/
	
	cp -uv ~/work/cells/imgs/SCdata_hist{2,6,8}.svg imgs/
	cp -uv ~/work/cells/imgs/SC{inners,forces}-tracks.svg imgs/
	cp -uv ~/work/cells/imgs/SCforces-{potential,probabilities2}.svg imgs/
	cp -uv ~/work/cells/imgs/SC{inner,forces}-MSDs.svg imgs/
	
	cp -uv ~/work/cells/imgs/hardspheresNs100_MSD.svg imgs/
	cp -uv ~/work/cells/imgs/demo-caging-labeled.svg imgs/
	cp -uv ~/work/cells/imgs/floater_micro_rearrange.mp4 imgs/
	
	cp -uv ~/work/cells/imgs/hs_steps_F0.57.svg imgs/
	cp -uv ~/work/cells/imgs/hs_steps_F0.59.svg imgs/
	
	cp -uv ~/work/cells/imgs/hardspheresNs100_a2.svg imgs/
	cp -uv ~/work/cells/imgs/hardspheresNs_a2.svg imgs/
	
	cp -uv madeimgs/* imgs
	
imgs:
	mkdir imgs

clean:
	rm -f index{,2}{,_local}.html index-ref.adoc

%_local.html: %.html
	sed 's_https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.4.0_file:///usr/share/mathjax_g ; s_https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.2.0_file:///home/wendell/code/revealjs_g' $< > $@

local: index_local.html index2_local.html
