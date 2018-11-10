(define (problem industry-side) (:domain supply-chain)
(:objects 
    walmart - retail
    procter - industry
)

(:init
    ;todo: put the initial state's facts and numeric values here

    (= (stock procter) 1)
    (= (stock walmart) 0)
    
    (= (qtd-demand walmart) 1)
    (= (demand walmart) 0)

)

(:goal (and
        (= (demand walmart) 1)
    )
)

;un-comment the following line if metric is needed
;(:metric maximize (reward procter))
)
