#! /usr/bin/env python

rule felicitar_con_pastel:
    """
    Graficar un pastel de cumple para tu amiga o amigo
    """
    conda:
        "../envs/graficar_pastel.yaml"
    output:
        "results/celebracion/felicitaciones_para_{persona}.pdf"
    params:
        nombre = "{persona}",
        dob = lambda wc: people.loc[wc.persona]['fecha'],
        flavor = lambda wc: people.loc[wc.persona]['color_pastel'],
        frosting = lambda wc: people.loc[wc.persona]['color_frosting']
    log:
        "results/celebracion/pastel_{persona}.log"
    benchmark:
        "benchmarks/celebracion/pastel_{persona}.tsv"
    script:
        "../scripts/pastel.R"

