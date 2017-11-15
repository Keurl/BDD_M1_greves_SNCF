#include <iostream>
#include <fstream>

using namespace std;

void initialization(string insert[], int &compt, int beg[], int end[]){

    insert[0] = "INSERT INTO Temps VALUES (" + to_string(compt) + string(", to_date('");
    insert[1] = "INSERT INTO Motifs VALUES (" + to_string(compt) + string(",");
    insert[2] = "INSERT INTO Organisations VALUES (" + to_string(compt) + string(",");
    insert[3] = "INSERT INTO Metiers_Cibles VALUES ("  + to_string(compt) + string(",");
    insert[4] = "INSERT INTO Nb_Travailleurs VALUES (" + to_string(compt) + string(",");
    insert[5] = "INSERT INTO Table_Faits VALUES (" + to_string(compt) + string(",");

    for (int i = 0; i < 5; ++i)
        insert[5] += to_string(compt) + ',';

    for (int i = 0; i < 3; ++i){
        beg[i] = 0; 
        end[i] = 0;
    }

    compt++;
}

int main(int argc, char const *argv[]){


        ifstream read(argv[1], ios::in);  // We open the csv file for reading it
        ofstream write(argv[2], ios::out | ios::trunc); // We open a second file for writing in it
 		
        if(read && write){

            write << "SET SERVEROUTPUT OFF" << endl;
            write << "SET FEEDBACK OFF" << endl;
            write << "SET ECHO OFF" << endl << endl;
            // Initialization of the variables
        	string line ="";

        	getline(read,line);

        	char caracter;

            int comptAttr = 1, comptTuple = 1, comptNull = 1;

            string strBeg = "", strEnd = "", nbStrikers = "", nbWorkers = "", strikeReasons = "", strikeType = "";
            int dateBeg[3], dateEnd[3];

            string insertTable[6];

            initialization(insertTable, comptTuple, dateBeg, dateEnd);
            
            // For every caracters in our csv file
        	while(read.get(caracter)){

                // If we arrived at the end of a ligne (tuple)
        		if(caracter == '\n'){

                    int posPoint1 = strBeg.find('-',0);
                    int posPoint2 = strBeg.find('-',posPoint1+1);
                    dateBeg[0] = stoi(strBeg.substr(0,posPoint1));
                    dateBeg[1] = stoi(strBeg.substr(posPoint1+1,posPoint2-(posPoint1+1)));
                    dateBeg[2] = stoi(strBeg.substr(posPoint2+1,strBeg.size()-(posPoint2+1)));
    
                    // We found what the season is depanding of the date_beg[1] of the year
                    if(dateBeg[1] >= 1 && dateBeg[1] <= 3)
                        insertTable[0] += "\'Printemps\');";
                    else if(dateBeg[1] >= 4 && dateBeg[1] <= 6)
                        insertTable[0] += "\'Ete\');";
                    else if(dateBeg[1] >= 7 && dateBeg[1] <= 9)
                        insertTable[0] += "\'Automne\');";
                    else
                        insertTable[0] += "\'Hiver\');";
                    
                    // We calculate the rate of strikers
                    if(nbStrikers == "" && nbWorkers == "")
                        insertTable[5] += "NULL,";
                    else
                        insertTable[5] += to_string((stod(nbStrikers) *100) / stod(nbWorkers)) + ',';
                    
                    // We calculate the number of days of the strike
                    int nbDays = 1;
                    if(strEnd != ""){
                        posPoint1 = strEnd.find('-',0);
                        posPoint2 = strEnd.find('-',posPoint1+1);
                        dateEnd[0] = stoi(strEnd.substr(0,posPoint1));
                        dateEnd[1] = stoi(strEnd.substr(posPoint1+1,posPoint2-(posPoint1+1)));
                        dateEnd[2] = stoi(strEnd.substr(posPoint2+1,strEnd.size()-(posPoint2+1)));

                        if(dateEnd[0] - dateBeg[0] > 0){
                            nbDays += 365 * (dateEnd[0] - dateBeg[0]);
                        }
                        if(dateEnd[1] - dateBeg[1] > 0){
                            nbDays += 30 * (dateEnd[1] - dateBeg[1]);
                        }
                        if(dateEnd[2] - dateBeg[2] > 0){
                            nbDays += dateEnd[2] - dateBeg[2];
                        }
                    }

                    insertTable[5] += to_string(nbDays) + ");";

                    if(strikeReasons.find("retraite") != string::npos){
                        strikeType += "Retraite";
                    }
                    if(strikeReasons.find("condition") != string::npos){
                        if(strikeType != "")
                            strikeType += ',';

                        strikeType += "Conditions de travail";   
                    }
                    if(strikeReasons.find("salaire") != string::npos){
                       if(strikeType != "")
                           strikeType += ',';
                       
                       strikeType += "Salaire";   
                    }

                    if(strikeType == "")
                        insertTable[1] += "NULL);";
                    else
                        insertTable[1] += string("\'") + strikeType + string("\');");

                    // We write our insert in the file used for the creation of the tuples
                    for (int i = 0; i < 6; ++i){
                        write << insertTable[i] << "\n";
                        insertTable[i] = "";
                    }

                    // We jump a line just to make it more easy to read
                    write << "\n";

                    comptAttr = 1;
                    comptNull = 1;

                    // We initialize our array for the next tuple
                    initialization(insertTable, comptTuple, dateBeg, dateEnd);
                    
                    strBeg = ""; strEnd = ""; nbStrikers = ""; nbWorkers = ""; strikeReasons = ""; strikeType = "";

                // If we arrive at the end of an attribut
        		}else if(caracter == ';'){

                    comptNull++;
                    
                    // Depending on where we are in the line we add specifics caracters in a specific index of the array
                    switch (comptAttr){  
                        case 1:  
                            insertTable[5] += ",";
                            break;  
                        case 2:  
                            insertTable[0] += "','yyyy-mm-dd'),";
                            break;  
                        case 3:
                            if(comptNull > 2){ // Alors on a un élément NULL
                                insertTable[0] += "NULL,";
                                comptNull--;
                            }
                            else
                                insertTable[0] += "','yyyy-mm-dd'),";
                            break; 
                        case 4:
                            if(comptNull > 2){ // Alors on a un élément NULL
                                insertTable[1] += "NULL,";
                                comptNull--;
                            }
                            else
                                insertTable[1] += "\',";
                            break; 
                        case 5:
                            if(comptNull > 2){ // Alors on a un élément NULL
                                insertTable[2] += "NULL);";
                                comptNull--;
                            }
                            else
                                insertTable[2] += "\');";
                            break; 
                        case 6:
                            if(comptNull > 2){ // Alors on a un élément NULL
                                insertTable[3] += "NULL);";
                                comptNull--;
                            }
                            else  
                                insertTable[3] += "\');";
                            break; 
                        case 7: 
                            if(comptNull > 2) // Alors on a un élément NULL
                                insertTable[4] += "NULL,";
                            else 
                                insertTable[4] += ",";
                            break; 
                        case 8: 
                            if(comptNull > 2) // Alors on a un élément NULL
                                insertTable[4] += "NULL);";
                            else 
                                insertTable[4] += ");";
                            break; 
                        default:  
                            break;
                    } 
                    
                    comptAttr++;

                // If there is a quote, it mean we have an attribut with multi value
        		}else if(caracter == '\"'){

                    read.get(caracter);

                    while(caracter != '\"'){
                        if(caracter == ';'){
                            switch (comptAttr){   
                                case 4:  
                                    insertTable[1] += ',';
                                    break; 
                                case 5:  
                                    insertTable[2] += ',';
                                    break; 
                                case 6:  
                                    insertTable[3] += ',';
                                    break; 
                                default:
                                    break;
                            }
                        }else{
                           switch (comptAttr){   
                                case 4:
                                    if (comptNull == 2)
                                        insertTable[1] += '\'';

                                    if (caracter == '\'')
                                        insertTable[1] += '\'';

                                    insertTable[1] += caracter;
                                    break; 
                                case 5: 
                                    if (comptNull == 2)
                                        insertTable[2] += '\'';

                                    if (caracter == '\'')
                                        insertTable[2] += '\'';

                                    insertTable[2] += caracter;
                                    break; 
                                case 6:
                                    if (comptNull == 2)
                                        insertTable[3] += '\'';

                                    if (caracter == '\'')
                                        insertTable[3] += '\'';

                                    insertTable[3] += caracter;
                                    break; 
                                default: 
                                    break;
                            }
                            comptNull = 1;
                        }
                        read.get(caracter);
                    }

                    comptNull = 1;

                // Else it's a common caracter
        		}else{

                    // Depending on where we are in the line we add specifics caracters and/or the read caracter in a specific index of the array
                    switch (comptAttr){  
                        case 1:  
                            insertTable[5] += caracter;
                            break;  
                        case 2:  
                            insertTable[0] += caracter;
                            strBeg += caracter;
                            break;  
                        case 3:
                            if (comptNull == 2)
                                insertTable[0] += string("to_date('");

                            insertTable[0] += caracter; 
                            strEnd += caracter;  
                            break; 
                        case 4:
                            if (comptNull == 2)
                                insertTable[1] += '\'';

                            if (caracter == '\'')
                                insertTable[1] += '\'';
                                    
                            insertTable[1] += caracter;
                            strikeReasons += caracter;
                            break; 
                        case 5:
                            if (comptNull == 2)
                                insertTable[2] += '\'';

                            if (caracter == '\'')
                                insertTable[2] += '\'';

                            insertTable[2] += caracter;
                            break; 
                        case 6:
                            if (comptNull == 2)
                                insertTable[3] += '\'';

                            if (caracter == '\'')
                                insertTable[3] += '\'';
                            
                            insertTable[3] += caracter;
                            break; 
                        case 7: 
                            insertTable[4] += caracter;
                            nbWorkers += caracter;
                            break; 
                        case 8:
                            insertTable[4] += caracter;
                            nbStrikers += caracter;
                            break; 
                        default:  
                             break; 
                    }

                    comptNull = 1;
        		}
        	}

            write << "\n" << "\n" << "@sql/privileges.sql";

            read.close();  // on ferme le fichier
            write.close();  // on ferme le fichier


            cout << endl << "Creation of the tuples succeded." << endl;
        }else  // sinon
            cerr << "Impossible d'ouvrir le fichier !" << endl;

        return 0;
}

