//Incluir esta libreriￂﾭa para poder hacer las llamadas en shiva2.upc.es
//#include <my_global.h>
#include <mysql.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
int main(int argc, char **argv)
{
	MYSQL *conn;
	int err;
	// Estructura especial para almacenar resultados de consultas 
	MYSQL_RES *resultado;
	MYSQL_RES *res;  // Declare res outside the conditional blocks
	
	MYSQL_ROW row;
	
	//Creamos una conexion al servidor MYSQL 
	conn = mysql_init(NULL);
	if (conn==NULL) {
		printf ("Error al crear la conexi￳n: %u %s\n", 
				mysql_errno(conn), mysql_error(conn));
		exit (1);
	}
	//inicializar la conexin
	conn = mysql_real_connect (conn, "localhost","root", "mysql", "Contrincantes",0, NULL, 0);
	if (conn==NULL) {
		printf ("Error al inicializar la conexion: %u %s\n", mysql_errno(conn), mysql_error(conn));
		exit (1);
	}
	// Consulta 1: Seleccionar las partidas en las que ha participado 'DragonMaster' y que también incluyen participación de 'MagicGamer'
	if (mysql_query(conn, "SELECT p.Partida FROM CONTRINCANTES c1 JOIN ParticipacionContrincantes p ON c1.IDContrincante = p.IDContrincante WHERE c1.NombreUsuarioContrincante = 'DragonMaster' AND p.Partida IN (SELECT p2.Partida FROM CONTRINCANTES c2 JOIN ParticipacionContrincantes p2 ON c2.IDContrincante = p2.IDContrincante WHERE c2.NombreUsuarioContrincante = 'MagicGamer');") != 0) {
		fprintf(stderr, "Consulta 1 falló: %s\n", mysql_error(conn));
	} else {
		res = mysql_store_result(conn);
		if (res != NULL) {
			printf("Consulta 1:\n");
			while ((row = mysql_fetch_row(res)) != NULL) {
				printf("Partida: %s\n", row[0]);
			}
			mysql_free_result(res);
		}
	}
	// Consulta 2: Seleccionar las partidas en las que ha participado 'DragonMaster' y mostrar la información sobre esas partidas
	if (mysql_query(conn, "SELECT p.Partida, p.Posicion, p.IDContrincante, c.NombreUsuarioContrincante, c.VecesJugado, c.EsAmigo FROM CONTRINCANTES c JOIN ParticipacionContrincantes p ON c.IDContrincante = p.IDContrincante WHERE c.NombreUsuarioContrincante = 'DragonMaster';") != 0) {
		fprintf(stderr, "Consulta 2 falló: %s\n", mysql_error(conn));
	} else {
		res = mysql_store_result(conn);
		if (res != NULL) {
			printf("Consulta 2:\n");
			while ((row = mysql_fetch_row(res)) != NULL) {
				printf("Partida: %s, Posicion: %s, IDContrincante: %s, NombreUsuario: %s, VecesJugado: %s, EsAmigo: %s\n",
					   row[0], row[1], row[2], row[3], row[4], row[5]);
			}
			mysql_free_result(res);
			}
		}
	// Cerrar la conexión
	mysql_close(conn);
	
	return 0;
}
	

	
