% Cargar Datos
% Dat - Columnas:
% 1 --> Longitud
% 2 --> Latitud
% 3 --> Población
% 4 --> Número de ITVs
% 5 --> Inspecciones
% 6 --> Población admite ITV de proximidad
% 7 --> Vehiculos por población

% Dat_txt - Columnas:
% 1 --> Comunidad Autónoma
% 2 --> Provincia
% 3 --> Ciudad

[Dat, Dat_txt] = xlsread('./CLM_Datos.xlsx');
[n,m] = size(Dat);

% Calcular Distancias
y = Dat(:,1)*(10000/90); % longitud pasada a coordenadas cartesianas
x = Dat(:,2)* (40000/60); % latitud pasada a coordenadas cartesianas
Pob = [x y];
D = squareform(pdist(Pob));

% Viabilidad
viabilidad_pob = ones(1, n); % Al comienzo todas las poblaciones son viables


% Algoritmo
continuar = 1;
while continuar == 1
    mejor_ratio = 0;
    mejor_ciudad = -1;
    mejor_inspecciones = 0;
    
    for i = 1:n
        if Dat(i,4) == 0 && viabilidad_pob(i) == 1 % Poblaciones sin ITV
            % Calculas nº inspecciones si colocamos una ITV en i
            inspecciones = PronosticarDemanda(i, Dat, D, n);

            param_rentabilidad = CalcularRentabilidad(i, Dat);

            ratio = inspecciones / param_rentabilidad;

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
        
        fprintf('La mejor población es %d y tendria ratio %d y %d inspecciones.\n', mejor_ciudad, mejor_ratio, mejor_inspecciones);
    else
        continuar = 0;
    end
    
    
    % Pintar poblaciones con ITV
    for k=1:n
        if Dat(k,4) > 0 % Poblaciones con ITV
            plot(Dat(k,2), Dat(k,1) ,'o')
            hold on
        end
    end
end