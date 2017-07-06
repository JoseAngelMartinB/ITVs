function [ nuevas_itv, Dat, n_nuevas ] = PonerITVs( Dat, D, n, nuevas_itv )
%PONERITVS 
%   Utiliza un algoritmo Greedy para añadir nuevas ITVs en las poblaciones
%   donde se obtenga un mejor ratio de rentabilidad.
%   Argumentos:
%   - Dat           Datos
%   - D             Distancia entre poblaciones
%   - n             Número de poblaciones
%   - nuevas_itv    Nuevas ITVs añadidas

    viabilidad_pob = ones(1, n); % Al comienzo todas las poblaciones son viables
    n_nuevas = 0;
    continuar = 1;
    
    while continuar == 1
        mejor_ratio = 0;
        mejor_ciudad = -1;
        mejor_inspecciones = 0;

        for i = 1:n
            if Dat(i,4) == 0 && viabilidad_pob(i) == 1 % Poblaciones sin ITV
                % Calcular nº inspecciones si colocamos una ITV en i
                inspecciones = PronosticarDemanda(i, Dat, D, n);

                ratio = RatioRentabilidad(i, inspecciones, Dat);

                if ratio >= 1 && ratio > mejor_ratio
                    mejor_ratio = ratio;
                    mejor_ciudad = i;   
                    mejor_inspecciones = inspecciones;
                end  

                if ratio < 1 % No es una ciudad viable para una nueva ITV
                    viabilidad_pob(i) = 0;
                end
            end
        end

        if mejor_ciudad > 0
            Dat(mejor_ciudad,4) = 1; % Se añade una ITV a esta población
            nuevas_itv = [nuevas_itv mejor_ciudad]; 
            n_nuevas = n_nuevas + 1;

            fprintf('\tLa mejor población es %d y tendria ratio %d y %d inspecciones.\n', mejor_ciudad, mejor_ratio, mejor_inspecciones);
        else
            continuar = 0;
        end

    end

end

