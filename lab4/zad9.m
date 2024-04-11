% Ustawienie dodatkowych opcji dla funkcji fzero
options = optimset('Display','iter');

% Wywołanie funkcji fzero dla pierwszego punktu startowego (x0 = 6.0)
[x1, fval1, exitflag1, output1] = fzero(@tan, 6.0, options);

% Wywołanie funkcji fzero dla drugiego punktu startowego (x0 = 4.5)
[x2, fval2, exitflag2, output2] = fzero(@tan, 4.5, options);

% Zapis wyników do pliku zadanie9.txt
fileID = fopen('zadanie9.txt','w');
fprintf(fileID,'Wynik dla pierwszego punktu startowego (x0 = 6.0):\n');
fprintf(fileID,'Miejsce zerowe: %f\n', x1);
fprintf(fileID,'Wartość funkcji w miejscu zerowym: %f\n', fval1);
fprintf(fileID,'Flaga zakończenia: %d\n', exitflag1);
fprintf(fileID,'Dodatkowe informacje:\n');
fprintf(fileID,'%s\n', output1.message);
fprintf(fileID,'Ilość iteracji: %d\n', output1.iterations);

fprintf(fileID,'\nWynik dla drugiego punktu startowego (x0 = 4.5):\n');
fprintf(fileID,'Miejsce zerowe: %f\n', x2);
fprintf(fileID,'Wartość funkcji w miejscu zerowym: %f\n', fval2);
fprintf(fileID,'Flaga zakończenia: %d\n', exitflag2);
fprintf(fileID,'Dodatkowe informacje:\n');
fprintf(fileID,'%s\n', output2.message);
fprintf(fileID,'Ilość iteracji: %d\n', output2.iterations);

fclose(fileID);
