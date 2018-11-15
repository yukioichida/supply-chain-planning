(define (problem near-real-problem) 

(:domain supply-chain)

(:objects 
    walmart - retail
    bestbuy - retail
    procter - vendor
    kraft - vendor
)

;One industry with the objective of attend the demand of one retail
(:init
    (= (total-cost) 0)
    
    ;procter
    (= (total-orders procter) 0)
    (= (made-items procter) 0)
    (= (storage-limit procter) 10)
    (= (max-capacity procter) 3)

    ;kraft
    (= (total-orders kraft) 0)
    (= (made-items kraft) 0)
    (= (storage-limit kraft) 5)
    (= (max-capacity kraft) 2)

    ; walmart
    (= (stock walmart procter) 0)
    (= (stock walmart kraft) 0)
    (= (monthly-demand walmart procter) 4) ; walmart sells 5 procter item per month
    (= (monthly-demand walmart kraft) 2) ; walmart sells 5 kraft item per month
    (= (demand walmart procter) 0)
    (= (demand walmart kraft) 0)
    (= (received-orders procter walmart) 0)
    (= (received-orders kraft walmart) 0)
    
    ; bestbuy
    (= (stock bestbuy procter) 0)
    (= (monthly-demand bestbuy procter) 5) ; bestbuy sells 5 procter item per month
    (= (demand bestbuy procter) 0)
    (= (received-orders procter bestbuy) 0)

    ; connections
    (connected procter bestbuy)
    (connected procter walmart)
    (connected kraft walmart)

    
)

; The goal of this problem is to generate a plan for Procter to deal with
; ONE demand of their products in the retail Walmart
(:goal (and
        (= (demand walmart procter) 1)
        (= (demand walmart kraft) 1)
        (= (demand bestbuy procter) 1)
    )
)

)
