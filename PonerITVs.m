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
    
    % Calculo de vector_dis_act
    vector_dis_act = zeros(1,n);
    for i=1:n
        vector_dis_act(i) = min(D(i, [Dat(:,4) > 0])) * 2; % Distancia a ITV más cecana
    end
    
    vector_inspec = D(:,7)';    
    
    while continuar == 1
        mejor_dis_tot = 0;
        mejor_ciudad = -1;
        mejor_vector_dis = [];

        for i = 1:n
            if Dat(i,4) == 0 && viabilidad_pob(i) == 1 % Poblaciones sin ITV
                [inspecciones, vector_dis] = PronosticarDemanda(i, Dat, D, n);
                ratio = RatioRentabilidad(i, inspecciones, Dat);

                if ratio >= 1
                    
                    dis_tot = sum((vector_dis_act-vector_dis).*vector_inspec);
                    
                    if dis_tot > mejor_dis_tot
                        mejor_dis_tot = dis_tot;
                        mejor_ciudad = i;
                        mejor_vector_dis = vector_dis;
                    end
                end  

                if ratio < 1 % No es una ciudad viable para una nueva ITV
                    viabilidad_pob(i) = 0;
                end
            end
        end

        if mejor_ciudad > 0
            Dat(mejor_ciudad,4) = 1; % Se añade una ITV a esta población
            nuevas_itv = [nuevas_itv mejor_ciudad]; 
            vector_dis_act = mejor_vector_dis;
            n_nuevas = n_nuevas + 1;
            
            fprintf('\tLa mejor población es %d y la distancia total sería %d.\n', mejor_ciudad, mejor_dis_tot);
        else
            continuar = 0;
        end

    end

end

