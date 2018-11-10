;Header and description

(define (domain supply-chain)

;remove requirements that are not needed
(:requirements :strips :fluents :typing :conditional-effects :negative-preconditions :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    retail industry
)

; Pensar em como diferenciar produtos por categorias
; Com a função de estoque, não temos a diferenciação de categorias
; Uma industria pode fornecer mais de uma categoria 
; Um varejo pode OU não vender produtos de mais de uma categoria
;(:constants )

; Verificar o stock out
; De repente ter conexões ponderadas (exemplo, zaffari teria um peso maior do que o varejo gecepel)
(:predicates
    (connected ?i - industry ?r - retail) ; indicates whether a retail is a connection of a industry
    (min-buffer-reached ?r - retail) ; indicates whether a retail needs replenishment
)

(:functions ;todo: define numeric functions here
    (buffer-reached ?x)
    (max-stock-buffer ?x)
    (min-stock-buffer ?x)
    (reward ?x)
    (stock ?x)
    (order-qty ?i - industry ?r - retail); Retail orders that an industry needs support
)

; TODO: Pensar em buffer de estoque max e min, sendo definido no effect que quando o 
; stock foi maior ou menor que o buffer, aumenta alguma métrica, que deve ser otimizada usando o fluents
;define actions here
(:action order
    :parameters (?r - retail
                 ?i - industry
                )
    :precondition (and 
                    (> (stock ?i) 0)
                )
    :effect (and 
                (increase (order-qty ?i ?r) 1)
            )
)

; Incluir diferentes tipos de ações - order50, order20, order 10
; Ver alguma forma de de repente ponderar cada ação, por exemplo order50 teria q penalizar mais o varejo
; Pensar em reward e orderQuantity, tipo, pensar num plano que MINIMIZE o orderQuantity

; consumeDemand - criar uma action que reduz o stock do varejo em um número fixo 
; um dos goals seria a quantidade de chamadas de consumeDemand (qtd-consume-demands)
; pensar que esse consumeDemand seria uma "leva de demanda"
; (supondo que seja a demanda media)

; Pensar sobre diferenciar entre stock fastMover e stock slowMover
(:action send
    :parameters (
        ?i - industry
        ?r - retail
    )
    
    :precondition (and 
                    (> (order-qty ?i ?r) 0)
                )

    :effect (and 
                (decrease (order-qty ?i ?r) 1)
                (increase (stock ?r) 1)
                (decrease (stock ?i) 1)
            )
)

;(:action sell
;    :parameters (?r - retail)
;    :precondition (and )
;    :effect (and 
;                (when   (> (min-stock-buffer ?r) (stock ?r))
;                        (increase (buffer-reached ?r) 1))
;                (increase (reward ?r) 1)
;            )
;)


)