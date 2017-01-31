<?php

	Class Crud 
	{
		protected $serverName = "";
		protected $dataLogin = array();
		protected $connection;

		public function Crud( $nameServer, $loginData )
		{
			$this->serverName = $nameServer;
			$this->dataLogin = $loginData;

			if( !is_string( $this->serverName ) and empty( $this->serverName )  )
			{
				throw new Exception("O nome do servidor é inválido ou vazio.");
			}

			if( !is_array( $this->dataLogin ) )
			{
				throw new Exception("As infomações de login precisam estar em um array.");
			}
			else
			{
				foreach( $this->dataLogin as $key => $value )
				{
					if( isset( $value ) and empty( $value ) )
					{
						throw new Exception("A informações não preenchidas no array de conexão.");
					}
				}
			}
		}

		public function OnConnect()
		{
			$this->connection = sqlsrv_connect( $this->serverName, $this->dataLogin );

			if( $this->connection )
			{
				return $this->connection;
			}
			else
			{
                throw new Exception( "Não foi possível se conectar com o banco de dados." );
			}
		}

		public function Select( $columnsName, $tableName, $where = false )
		{
            $fullQuery;
            $sqlRun;
            $queryRows;
            $results = array();

            if ( empty( $tableName ) and !is_string( $tableName ) )
			{
				throw new Exception( "Nome da tabela não especificado." );
			}

			if ( empty( $columnsName ) and !is_array( $columnsName ) )
			{
				throw new Exception( "As colunas devem ser um array." );
			}

			if ( $where and is_array($where) and !empty($where) )
			{
                $columnsName = implode(",",$columnsName);
				$fullQuery = strval("select $columnsName from $tableName where ? = ?");
                $sqlRun = sqlsrv_query( $this->connection, $fullQuery, $where );
			}
			else
			{
                $columnsName = implode(",",$columnsName);
				$fullQuery = strval("select $columnsName from $tableName");
                $sqlRun = sqlsrv_query( $this->connection, $fullQuery );
			}

			if ( $sqlRun )
			{
				while( $queryRows = sqlsrv_fetch_array( $sqlRun, SQLSRV_FETCH_ASSOC ) )
				{
					array_push( $results, $queryRows );
				}

				sqlsrv_close( $this->connection );
				return $results;
			}
			else
			{
				sqlsrv_close( $this->connection );
				return sqlsrv_errors();
			}
		}

        public function Insert( $columnsValues, $tableName, $image = false )
        {
            $columns = implode( ",", array_keys( $columnsValues ) );
            $columnsCount;
            $query = "";
            $queryRun;

            if ( empty( $tableName ) and !is_string( $tableName ) )
            {
                throw new Exception( "O nome da tabela precisa ser especificado." );
            }

            if ( empty( $columnsValues ) and !is_array( $columnsValues ) )
            {
                throw new Exception( "Os valores devem ser um array." );
            }

            for( $i = 0; $i < count( $columnsValues ); $i++ )
            {
                $columnsCount[$i] = "?";
            }

            if ( $image and !empty( $image ) and is_array( $image ) )
            {
                foreach( $image as $key => $value )
                {
                    $openImg = fopen( $value["tmp_name"], "rb" );
                    $contentImg = fread( $openImg, filesize( $value["tmp_name"] ) );
                    fclose( $openImg );

                    $image[$key] = array(
                        $contentImg,
                        SQLSRV_PARAM_IN,
                        SQLSRV_PHPTYPE_STREAM(SQLSRV_ENC_BINARY),
                        SQLSRV_SQLTYPE_VARBINARY('max')
                    );

                    if ( array_key_exists( $key, $columnsValues ) )
                    {
                        $columnsValues[$key] = $image[$key];
                    }
                }

                $columnsCount = implode( ",", $columnsCount );
                $query = "insert into $tableName ($columns) values ($columnsCount)";
                $queryRun = sqlsrv_query( $this->connection, $query, $columnsValues );

                if( $queryRun )
                {
                    return $queryRun;
                }
                else
                {
                    return sqlsrv_errors();
                }
            }
            else
            {
                $columnsCount = implode( ",", $columnsCount );
                $query = "insert into $tableName ($columns) values ($columnsCount)";
                $queryRun = sqlsrv_query( $this->connection, $query, $columnsValues );

                if( $queryRun )
                {
                    return $queryRun;
                }
                else
                {
                    return sqlsrv_errors();
                }
            }
        }
	}

	$dbServerName = "WILLIAM-K45VM";
	$dbConnectionInfo = array(
		"Database" => "senac_pi_2",
		"UID" => "sa",
		"PWD" => "final945542",
		"CharacterSet" => "UTF-8"
	);

	$databaseManager = new Crud($dbServerName, $dbConnectionInfo);
	$databaseManager->OnConnect();

    $nameTable = "Produto";
    $valuesToInsert = array(
        "nomeProduto" => "Tênis Addidas",
        "descProduto" => "Um tênis da Addidas",
        "precProduto" => 299.90,
        "descontoProduto" => 20.00,
        "idCategoria" => 1,
        "ativoProduto" => 1,
        "idUsuario" => 1,
        "qtqMinEstoque" => 20,
        "imagem" => "imagem_produto"
    );

	var_dump( $databaseManager->Insert( $valuesToInsert, $nameTable, $_FILES ) );
?>

<html>
    <head>
        <title></title>
    </head>
    <body>
        <form action="#" enctype="multipart/form-data" method="post">
            <input type="file" name="imagem_produto">
            <button>Enviar</button>
        </form>
    </body>
</html>