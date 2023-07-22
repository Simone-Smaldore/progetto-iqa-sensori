function [valori, percentuale] = trovaIntrusi(T)
        % trova utenti diversi con score alto (soglia fissata)
        valori = T;
        for i = 1:size(T,1)
            s1 = extractBefore(T.Utente1(i), '.');
            s2 = extractBefore(T.Utente2(i), '.');
            if (strcmp(s1, s2) || T.ScoreML(i) < 0.5)
                 valori(i,:) = {''     ''    0, 0};
            end
        end
        valori = sortrows(valori,'ScoreML', 'descend');
        i = find(~valori.ScoreML);
        i = i(1) - 1;
        valori = table(valori.Utente1(1:i), valori.Utente2(1:i), valori.ScoreML(1:i));
        percentuale = 100 * size(valori,1) / size(T,1);
end