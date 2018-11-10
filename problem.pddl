(define (problem industry-side) (:domain supply-chain)
(:objects 
    walgreens - retail
    walmart - retail
    procter - industry
)

(:init
    ;todo: put the initial state's facts and numeric values here
    (= (reward procter) 2)
    (= (reward walmart) 2)
    (= (reward walgreens) 2)

    (= (stock procter) 1)
    (= (stock walgreens) 0)
    (= (stock walmart) 0)
    ; comentar a relação da quantidade de varejo com o tamanho da árvore
    ; analysis of complexity

    (connected procter walgreens)
    (connected procter walmart)


    (= (order-qty procter walgreens) 0)
    (= (order-qty procter walmart) 0)

)

(:goal (and
        (= (stock walgreens) 5)
        (= (stock walmart) 5)
    )
)

;un-comment the following line if metric is needed
;(:metric maximize (reward procter))
)
