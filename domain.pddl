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
    (buffer-reached ?r - retail) ; indicates whether a retail needs replenishment
)

(:functions ;todo: define numeric functions here
    (stock ?x)
    (demand ?r - retail)
    (qtd-demand ?r - retail)
)

(:action order
    :parameters (?i - industry
                 ?r - retail
                )
    :precondition (and 
                    (> (stock ?i) 0)
                )
    :effect (and 
                (increase (stock ?r) 1)
                (decrease (stock ?i) 1)
    )
)

(:action attend-demand
    :parameters (?r - retail)
    :precondition (and 
                        (>= (stock ?r) (qtd-demand ?r))
    )
    :effect (and 
                (decrease (stock ?r) (qtd-demand ?r))
                (increase (demand ?r) 1)
            )
)


)