% main.m
% José Ángel Martín Baos
% Ricardo García Rodenas
% Doroteo Verastegui Rayo

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



% Algoritmo
nuevas_itv = [];
continuar = 1;
iteracion = 1; 

while continuar == 1
    [nuevas_itv, Dat, n_nuevas] = PonerITVs(Dat, D, n, nuevas_itv);
    [nuevas_itv, Dat, n_eliminadas] = QuitarITVs(Dat, D, n, nuevas_itv);
    
    
    fprintf('Iteración %d: %d ITVs añadidas, %d ITVs eliminadas.\n', iteracion, n_nuevas, n_eliminadas);
    
    iteracion = iteracion + 1;
    
    if n_nuevas == 0 && n_eliminadas == 0
        continuar = 0;
    end
end


[~ , n_nuevas] = size(nuevas_itv);
fprintf('Algoritmo terminado. %d nuevas ITVs\n', n_nuevas);

% Guardar soluciones
Visualizacion(Dat, nuevas_itv, n);


