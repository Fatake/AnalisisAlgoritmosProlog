:- use_module(library(tabular)).
:- use_module(library(autowin)).

make_table :-
        new(P, auto_sized_picture('Conecta 4')),%Esta madre crea una ventana
        send(P, display, new(T, tabular)),
        send(T, border, 0),
        send(T, cell_spacing, -1),
        send(T, rules, all),
        send_list(T,
                  [ append(new(graphical), rowspan := 2),
                    append('Length/mm', bold, center, colspan := 3),
                    next_row,
                    append('body', bold, center),
                    append('tail', bold, center),
                    append('ears', bold, center),
                    next_row,
                    append('males', bold),
                    append('31.4'),
                    append('23.7'),
                    append('3.8'),
                    next_row,
                    append('females', bold),
                    append('29.6'),
                    append('20.8'),
                    append('3.4')
                  ]),
        send(P, open).