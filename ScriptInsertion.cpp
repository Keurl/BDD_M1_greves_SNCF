#include <iostream>
#include <fstream>

using namespace std;


int main(int argc, char const *argv[]){


        ifstream read(argv[1], ios::in);  // on ouvre le fichier en lecture
        ofstream write(argv[2], ios::out | ios::trunc);
 		
        if(read && write){ // si l'ouverture a réussi 

        	string line ="";

        	getline(read,line);

        	char caracter;

            int comptAttr = 1;
            int comptTuple = 1;
            int comptNull = 1;
            
            string insertTable[6];

            insertTable[0] = "INSERT INTO Temps VALUES (" + to_string(comptTuple) + string(", to_date('");
            insertTable[1] = "INSERT INTO Motifs VALUES (" + to_string(comptTuple) + string(",\"");
            insertTable[2] = "INSERT INTO Orga VALUES (" + to_string(comptTuple) + string(",\"");
            insertTable[3] = "INSERT INTO Metiers_Cibles VALUES ("  + to_string(comptTuple) + string(",\"");
            insertTable[4] = "INSERT INTO Nb_Travailleurs VALUES (" + to_string(comptTuple) + string(",");
            insertTable[5] = "INSERT INTO Table_Faits VALUES (" + to_string(comptTuple);

            for (int i = 0; i < 5; ++i)
                insertTable[5] += ',' + to_string(comptTuple);

            insertTable[5] += ");";   
            
        	while(read.get(caracter)){

        		if(caracter == '\n'){

                    comptNull = 1;

                    for (int i = 0; i < 6; ++i){
                        write << insertTable[i] << "\n";
                        insertTable[i] = "";
                    }
                    write << "\n";

                    comptAttr = 1;
                    insertTable[0] = "INSERT INTO Temps VALUES (" + to_string(comptTuple) + string(", to_date('");
                    insertTable[1] = "INSERT INTO Motifs VALUES (" + to_string(comptTuple) + string(",\"");
                    insertTable[2] = "INSERT INTO Orga VALUES (" + to_string(comptTuple) + string(",\"");
                    insertTable[3] = "INSERT INTO Metiers_Cibles VALUES ("  + to_string(comptTuple) + string(",\"");
                    insertTable[4] = "INSERT INTO Nb_Travailleurs VALUES (" + to_string(comptTuple) + string(",");
                    insertTable[5] = "INSERT INTO Table_Faits VALUES (" + to_string(comptTuple);

                    for (int i = 0; i < 5; ++i)
                        insertTable[5] += ',' + to_string(comptTuple);

                    insertTable[5] += ");";  
                    
                    comptTuple++;
        		}else if(caracter == ';'){

                    comptNull++;
                    if(comptNull > 2){ // Alors on a un élément NULL
                        switch (comptAttr){
                            case 1:  
                                
                                break;  
                            case 2:  
                                insertTable[0] += "','yyyy-mm-dd'),";
                                break;  
                            case 3:  
                                insertTable[0] += "NULL);";
                                break; 
                            case 4:  
                                 insertTable[1] += "\");";
                                break; 
                            case 5:  
                                insertTable[2] += "\");";
                                break; 
                            case 6:  
                                insertTable[3] += "\");";
                                break; 
                            case 7:  
                                insertTable[4] += "NULL";
                                break; 
                            case 8:  
                                insertTable[4] += ",NULL";
                                break; 
                            case 9:  
                                insertTable[4] += ",NULL);";
                                break; 
                            default:  
                                break;
                        } 
                    }else{
                        switch (comptAttr){  
                            case 1:  
                                
                                break;  
                            case 2:  
                                insertTable[0] += "','yyyy-mm-dd'),";
                                break;  
                            case 3:  
                                insertTable[0] += "','yyyy-mm-dd'));";
                                break; 
                            case 4:  
                                 insertTable[1] += "\");";
                                break; 
                            case 5:  
                                insertTable[2] += "\");";
                                break; 
                            case 6:  
                                insertTable[3] += "\");";
                                break; 
                            case 7:  
                                insertTable[4] += ",";
                                break; 
                            case 8:  
                                insertTable[4] += ",";
                                break; 
                            case 9:  
                                insertTable[4] += ");";
                                break; 
                            default:  
                                break;
                        } 
                    }
                    comptAttr++;

        		}else if(caracter == '\"'){
                    
                    comptNull = 1;

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
                                    insertTable[1] += caracter;
                                    break; 
                                case 5:  
                                    insertTable[2] += caracter;
                                    break; 
                                case 6:  
                                    insertTable[3] += caracter;
                                    break; 
                                default: 
                                    break;
                            }
                        }
                        read.get(caracter);
                    }

        		}else{

                    switch (comptAttr){  
                        case 1:  
                             
                            break;  
                        case 2:  
                            insertTable[0] += caracter;
                            break;  
                        case 3:
                            if (comptNull == 2){
                                insertTable[0] += string("to_date('") + caracter; 
                            }else{
                                insertTable[0] += caracter;    
                            }
                            break; 
                        case 4:  
                            insertTable[1] += caracter;
                            break; 
                        case 5:  
                            insertTable[2] += caracter;
                            break; 
                        case 6:  
                            insertTable[3] += caracter;
                            break; 
                        case 7:  
                            insertTable[4] += caracter;
                            break; 
                        case 8:  
                            insertTable[4] += caracter;
                            break; 
                        case 9:  
                            insertTable[4] += caracter;
                            break; 
                        default:  
                             break; 
                    }

                    comptNull = 1;
        		}
        	}

            read.close();  // on ferme le fichier
            write.close();  // on ferme le fichier
        }else  // sinon
            cerr << "Impossible d'ouvrir le fichier !" << endl;

        return 0;
}