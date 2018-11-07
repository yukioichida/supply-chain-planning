(define (problem pb1) (:domain supply-chain)
(:objects 
    walgreens - retail
    procter - industry
)

(:init
    ;todo: put the initial state's facts and numeric values here
    (= (stock procter) 20)
    (= (stock walgreens) 0)
    (connected procter walgreens)
)

(:goal (and
        (= (stock walgreens) 2)
    )
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
