all: index2.html index.html

index.html: index-ref.adoc Makefile  #imgs/*
	asciidoctor -b html5 -T ~/code/ascreveal/templates/slim index-ref.adoc -o index.html

index2.html: index-ref.adoc Makefile #imgs/*
	asciidoctor -b html5 index-ref.adoc -o index2.html
	
index-ref.adoc: index.adoc thesis.bib
	asciidoc-bib -b thesis.bib -s "american-physics-society" index.adoc

copies: Makefile | imgs
	cp ~/work/papers/thesis/thesis.bib .
	
imgs:
	mkdir imgs

clean:
	rm -f index{,2}{,_local}.html index-ref.adoc

local: index.html index2.html
	sed 's_https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.4.0_file:///usr/share/mathjax_g ; s_https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.2.0_file:///home/wendell/code/revealjs_g' index.html > index_local.html
	sed 's_https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.4.0_file:///usr/share/mathjax_g ; s_https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.2.0_file:///home/wendell/code/revealjs_g' index2.html > index2_local.html
