#! /usr/bin/env python

rule felicitar_con_pastel:
    """
    Graficar un pastel de cumple para tu amiga o amigo
    """"
    conda:
        "../envs/graficar_pastel.yaml"
    output:
        "results/celebracion/felicitaciones_para_{persona}.pdf"
    params:
        nombre = "{persona}",
        dob = config[festejadx][fecha],
        flavor = config[pastel][color],
        frosting = config[pastel][frosting]
    log:
        "results/celebracion/pastel_{persona}.log"
    benchmark:
        "benchmarks/celebraciones/pastel_{persona}.tsv"
    script:
        "../scripts/pastel.R"

