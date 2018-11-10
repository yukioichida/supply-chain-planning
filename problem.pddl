(define (problem industry-side) (:domain supply-chain)
(:objects 
    walmart - retail
    walgreens - retail
    procter - industry
)

(:init
    ;todo: put the initial state's facts and numeric values here

    (= (stock procter) 0)

    (= (stock walmart) 0)
    (= (qtd-demand walmart) 1)
    (= (demand walmart) 0)

    (= (stock walgreens) 0)
    (= (qtd-demand walgreens) 1)
    (= (demand walgreens) 0)

)

(:goal (and
        (= (demand walmart) 3)
        (= (demand walgreens) 3)
    )
)

;un-comment the following line if metric is needed
;(:metric maximize (reward procter))
)
