(define (problem simple-problem) 

(:domain supply-chain)

(:objects 
    walmart - retail
    procter - vendor
)

;One industry with the objective of attend the demand of one retail
(:init
    (= (total-cost) 0)
    
    (= (total-orders procter) 0)
    (= (made-items procter) 0)
    (= (storage-limit procter) 10)
    (= (max-capacity procter) 3)

    (connected procter walmart)

    (= (stock walmart procter) 0)
    (= (monthly-demand walmart procter) 5) ; walmart sells one procter item per month
    (= (demand walmart procter) 0)

    (= (received-orders procter walmart) 0)
)

; The goal of this problem is to generate a plan for Procter to deal with
; ONE demand of their products in the retail Walmart
(:goal (and
        (= (demand walmart procter) 1)
    )
)

)
