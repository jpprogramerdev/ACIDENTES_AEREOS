USE ACIDENTES_AEREOS;
GO


--Proc de paises
CREATE PROCEDURE Proc_InserirPaises
AS 
BEGIN
	DECLARE @V_Count INT;
	DECLARE @V_Pais NVARCHAR(100);
	DECLARE @V_IdPais INT;

	DECLARE CURSOR_PAS CURSOR FOR
	SELECT
		aeronave_pais_fabricante
	FROM 
		planilha_aeronave;

	OPEN CURSOR_PAS;
	
	FETCH NEXT FROM
		CURSOR_PAS
	INTO
		@V_Pais;
		

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM PAISES WHERE PAS_NOME = @V_Pais OR CAST(PAS_ID AS varchar) = @V_Pais;

			IF @V_Count = 0 
				BEGIN
					INSERT INTO PAISES(PAS_NOME) VALUES (@V_Pais);
					SELECT @V_IdPais = SCOPE_IDENTITY();
				END;

			SELECT @V_IdPais = PAS_ID FROM PAISES WHERE PAS_NOME = @V_Pais OR CAST(PAS_ID AS varchar) = @V_Pais;


			UPDATE planilha_aeronave SET aeronave_pais_fabricante = @V_IdPais WHERE aeronave_pais_fabricante = @V_Pais;
		
			FETCH NEXT FROM
				CURSOR_PAS
			INTO
				@V_Pais;

		END;
	
	DEALLOCATE CURSOR_PAS
END;
GO


--Proc do tipo icao
CREATE PROCEDURE Proc_InserirTipoIcao
AS
BEGIN
	DECLARE @V_IdIcao INT;
	DECLARE @V_Count INT;
	DECLARE @V_ICAO VARCHAR(5);

	DECLARE CURSOR_TPI CURSOR FOR
	SELECT
		aeronave_tipo_icao
	FROM planilha_aeronave;
	
	OPEN CURSOR_TPI;

	FETCH NEXT FROM
		CURSOR_TPI
	INTO
		@V_ICAO;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM TIPOS_ICAO WHERE TPI_ICAO = @V_ICAO OR CAST(TPI_ID AS varchar) = @V_ICAO; 

			IF @V_Count = 0
				BEGIN
					INSERT INTO TIPOS_ICAO(TPI_ICAO) VALUES (@V_ICAO);
				END;

			SELECT @V_IdIcao = TPI_ID FROM TIPOS_ICAO WHERE TPI_ICAO = @V_ICAO OR CAST(TPI_ID AS varchar) = @V_ICAO;
	
			UPDATE planilha_aeronave SET aeronave_tipo_icao = @V_IdIcao WHERE aeronave_tipo_icao = @V_ICAO;

			FETCH NEXT FROM
				CURSOR_TPI
			INTO
				@V_ICAO;
		END;
	
	DEALLOCATE CURSOR_TPI;

END;
GO


--Proc PMD
CREATE PROCEDURE Proc_InserirPMD
AS
BEGIN
	DECLARE @V_IdPMD INT;
	DECLARE @V_Count INT;
	DECLARE @V_PMD INT

	DECLARE CURSOR_PMD CURSOR FOR
	SELECT
		CAST(aeronave_pmd AS INT)
	FROM
		planilha_aeronave;

	OPEN CURSOR_PMD;

	FETCH NEXT FROM
		CURSOR_PMD
	INTO
		@V_PMD;


	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM PESOS_MAXIMOS_DECOLAGEM WHERE PMD_PESO = @V_PMD OR PMD_ID = @V_PMD;

			IF @V_Count = 0
				BEGIN
					INSERT INTO PESOS_MAXIMOS_DECOLAGEM(PMD_PESO) VALUES (@V_PMD);
				END;

			SELECT @V_IdPMD = PMD_ID FROM PESOS_MAXIMOS_DECOLAGEM WHERE PMD_PESO = @V_PMD OR PMD_ID = @V_PMD;

			UPDATE planilha_aeronave SET aeronave_pmd = @V_IdPMD WHERE aeronave_pmd = @V_PMD;

			FETCH NEXT FROM
				CURSOR_PMD
			INTO
				@V_PMD;
		END;

	DEALLOCATE CURSOR_PMD;
END;
GO


--Proc Tipo de Aeronave
CREATE PROCEDURE Proc_InserirTipoAeronave
	
AS
BEGIN
	DECLARE @V_IdTipoAeronave INT;
	DECLARE @V_Count INT;
	DECLARE @V_TipoAeronave NVARCHAR(200)

	DECLARE CURSOR_TPA CURSOR FOR
	SELECT
		COALESCE(aeronave_tipo_veiculo, 'N/A')
	FROM
		planilha_aeronave;

	OPEN CURSOR_TPA;

	FETCH NEXT FROM
		CURSOR_TPA
	INTO
		@V_TipoAeronave;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM TIPOS_AERONAVE WHERE TPA_TIPO = @V_TipoAeronave OR CAST(TPA_ID AS VARCHAR) = @V_TipoAeronave;

			IF @V_Count = 0
				BEGIN
					INSERT INTO TIPOS_AERONAVE(TPA_TIPO) VALUES (@V_TipoAeronave);
				END;

			SELECT @V_IdTipoAeronave = TPA_ID FROM TIPOS_AERONAVE WHERE TPA_TIPO = @V_TipoAeronave OR CAST(TPA_ID AS VARCHAR) = @V_TipoAeronave;


			UPDATE planilha_aeronave SET aeronave_tipo_veiculo = @V_IdTipoAeronave WHERE aeronave_tipo_veiculo = @V_TipoAeronave;

			FETCH NEXT FROM
				CURSOR_TPA
			INTO
				@V_TipoAeronave;
		END;
	
	DEALLOCATE CURSOR_TPA;

END;
GO


--Proc Fabricantes
CREATE PROCEDURE Proc_InserirFabricanteAeronave
AS 
BEGIN
	DECLARE @V_IdFabricante INT;
	DECLARE @V_Count INT;
	DECLARE @V_Fabricante NVARCHAR(200)

	DECLARE CURSOR_FBA CURSOR FOR
	SELECT
		aeronave_fabricante
	FROM 
		planilha_aeronave;

	OPEN CURSOR_FBA;

	FETCH NEXT FROM
		CURSOR_FBA
	INTO
		@V_Fabricante;


	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM FABRICANTES_AERONAVES WHERE FBA_NOME = @V_Fabricante OR CAST(FBA_ID AS VARCHAR) = @V_Fabricante;

			IF @V_Count = 0
				BEGIN
					INSERT INTO FABRICANTES_AERONAVES (FBA_NOME) VALUES (@V_Fabricante);
				END;

			SELECT @V_IdFabricante = FBA_ID FROM FABRICANTES_AERONAVES WHERE FBA_NOME = @V_Fabricante OR CAST(FBA_ID AS VARCHAR) = @V_Fabricante;

			UPDATE planilha_aeronave SET aeronave_fabricante = @V_IdFabricante WHERE aeronave_fabricante = @V_Fabricante;

			FETCH NEXT FROM
				CURSOR_FBA
			INTO
				@V_Fabricante;
		END;

	DEALLOCATE CURSOR_FBA;

END;
GO


--Proc Tipos motores
CREATE PROCEDURE Proc_InserirTipoMotores
AS
BEGIN
	DECLARE @V_Tipo VARCHAR(100);
	DECLARE @V_IdTPM INT;
	DECLARE @V_Count INT;

	DECLARE CURSOR_TPM CURSOR FOR
	SELECT
		aeronave_motor_tipo
	FROM
		planilha_aeronave;


	OPEN CURSOR_TPM;

	FETCH NEXT FROM
		CURSOR_TPM
	INTO
		@V_Tipo;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM TIPOS_MOTORES WHERE TPM_TIPO = @V_Tipo OR CAST(TPM_ID AS VARCHAR) = @V_Tipo;

			IF @V_Count = 0
				BEGIN
					INSERT INTO TIPOS_MOTORES(TPM_TIPO) VALUES (@V_Tipo);
				END;

			SELECT @V_IdTPM = TPM_Id FROM TIPOS_MOTORES WHERE TPM_TIPO = @V_Tipo OR CAST(TPM_ID AS VARCHAR) = @V_Tipo

			UPDATE planilha_aeronave SET aeronave_motor_tipo = @V_IdTPM WHERE aeronave_motor_tipo = @V_Tipo;

			FETCH NEXT FROM
				CURSOR_TPM
			INTO
				@V_Tipo;
		END;

	DEALLOCATE CURSOR_TPM;

END;
GO


--Proc Inseriri Quantidade Motores
CREATE PROCEDURE Proc_InseririQuantidadeMotores
AS
BEGIN
	DECLARE @V_Quantidade VARCHAR(100);
	DECLARE @V_IdQTM INT;
	DECLARE @V_Count INT;

	DECLARE CURSOR_QTM CURSOR FOR
	SELECT
		aeronave_motor_quantidade
	FROM
		planilha_aeronave;

	OPEN CURSOR_QTM;

	FETCH NEXT FROM
		CURSOR_QTM
	INTO
		@V_Quantidade;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM QUANTIDADES_MOTORES WHERE QTM_Tipo = @V_Quantidade OR CAST(QTM_ID AS VARCHAR) = @V_Quantidade;

			IF @V_Count = 0
				BEGIN
					INSERT INTO QUANTIDADES_MOTORES(QTM_Tipo) VALUES (@V_Quantidade);
				END;

			SELECT @V_IdQTM = QTM_ID FROM QUANTIDADES_MOTORES WHERE QTM_Tipo = @V_Quantidade OR CAST(QTM_ID AS VARCHAR) = @V_Quantidade;

			UPDATE planilha_aeronave SET aeronave_motor_quantidade = @V_IdQTM WHERE aeronave_motor_quantidade = @V_Quantidade;

			FETCH NEXT FROM 
				CURSOR_QTM
			INTO
				@V_Quantidade;
		END;

	DEALLOCATE CURSOR_QTM;

END;
GO


--Proc Inserir Niveis danos acidentes
CREATE PROCEDURE Proc_InserirNiveisDados
AS
BEGIN
	DECLARE @V_Niveis VARCHAR(100);
	DECLARE @V_IdNVA INT;
	DECLARE @V_Count INT;

	DECLARE CURSOR_NVA CURSOR FOR
	SELECT
		aeronave_nivel_dano
	FROM
		planilha_aeronave;

	OPEN CURSOR_NVA;

	FETCH NEXT FROM
		CURSOR_NVA
	INTO
		@V_Niveis;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM NIVEIS_DANOS_ACIDENTES WHERE NVA_NIVEL = @V_Niveis OR CAST(NVA_ID AS VARCHAR) = @V_Niveis;

			IF @V_Count = 0
				BEGIN
					INSERT INTO NIVEIS_DANOS_ACIDENTES(NVA_NIVEL) VALUES (@V_Niveis);
				END;

			SELECT @V_IdNVA = NVA_ID FROM NIVEIS_DANOS_ACIDENTES WHERE NVA_NIVEL = @V_Niveis OR CAST(NVA_ID AS VARCHAR) = @V_Niveis;

			UPDATE planilha_aeronave SET aeronave_nivel_dano = @V_IdNVA WHERE aeronave_nivel_dano = @V_Niveis;
		
			FETCH NEXT FROM
				CURSOR_NVA
			INTO
				@V_Niveis;
		END;

	DEALLOCATE CURSOR_NVA

END;
GO


--Proc tipos segmentos
CREATE PROCEDURE Proc_InserirTiposSegmentos
AS
BEGIN
	DECLARE @V_Operacao VARCHAR(100);
	DECLARE @V_IdTPS INT;
	DECLARE @V_Count INT;

	DECLARE CURSOR_TPS CURSOR FOR
	SELECT
		aeronave_registro_segmento
	FROM
		planilha_aeronave;

	OPEN CURSOR_TPS;

	FETCH NEXT FROM
		CURSOR_TPS
	INTO
		@V_Operacao;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM TIPOS_SEGMENTOS WHERE TPS_OPERACAO = @V_Operacao OR CAST(TPS_ID AS VARCHAR)= @V_Operacao;

			IF @V_Count = 0
				BEGIN
					INSERT INTO TIPOS_SEGMENTOS(TPS_OPERACAO) VALUES (@V_Operacao);
				END;

			SELECT @V_IdTPS = TPS_ID FROM TIPOS_SEGMENTOS WHERE TPS_OPERACAO = @V_Operacao OR CAST(TPS_ID AS VARCHAR)= @V_Operacao;

			UPDATE planilha_aeronave SET aeronave_registro_segmento = @V_IdTPS WHERE aeronave_registro_segmento = @V_Operacao;
			
			FETCH NEXT FROM
				CURSOR_TPS
			INTO
				@V_Operacao;
		END;

	DEALLOCATE CURSOR_TPS;

END;
GO


--Proc Inserir modelos Aeronaves
CREATE PROCEDURE Proc_InserirModelosAeronaves
AS
BEGIN
	DECLARE @V_IdModeloAeronave INT;
	DECLARE @V_Count INT;
	DECLARE @V_Modelo NVARCHAR(100);
	DECLARE @V_Assentos INT;
	DECLARE @V_IdIcao INT;
	DECLARE @V_IdPMD INT;
	DECLARE @V_IdTipoAeronave INT;
	DECLARE @V_IdFabricante INT;

	DECLARE CURSOR_MDA CURSOR DYNAMIC FOR
	SELECT
		aeronave_modelo,
		CASE 
			WHEN aeronave_assentos = 'NULL' THEN CAST('0' AS INT)
			ELSE CAST(aeronave_assentos AS INT)
		END,
		CAST(aeronave_tipo_icao AS INT),
		CAST(aeronave_pmd AS INT),
		CAST(aeronave_tipo_veiculo AS INT),
		CAST(aeronave_fabricante AS INT)
	FROM
		planilha_aeronave;

	OPEN CURSOR_MDA;

	FETCH NEXT FROM
		CURSOR_MDA
	INTO
		@V_Modelo,
		@V_Assentos,
		@V_IdIcao,
		@V_IdPMD,
		@V_IdTipoAeronave,
		@V_IdFabricante;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT 
				@V_Count = COUNT(*) 
			FROM MODELOS_AERONAVES WHERE
				(MDA_MODELO = @V_Modelo OR CAST(MDA_ID AS VARCHAR) = @V_Modelo) AND
				MDA_ASSENTOS = @V_Assentos AND 
				MDA_FBA_ID = @V_IdFabricante AND
				MDA_TPI_ID = @V_IdIcao AND
				MDA_PMD_ID = @V_IdPMD AND
				MDA_TPA_ID = @V_IdTipoAeronave;

			IF @V_Count = 0
				BEGIN
					INSERT INTO MODELOS_AERONAVES(MDA_MODELO, MDA_ASSENTOS, MDA_FBA_ID, MDA_TPI_ID, MDA_PMD_ID, MDA_TPA_ID) 
					VALUES (@V_Modelo, @V_Assentos, @V_IdFabricante, @V_IdIcao, @V_IdPMD, @V_IdTipoAeronave);
				END;

			SELECT 
				@V_IdModeloAeronave = MDA_ID 
			FROM MODELOS_AERONAVES WHERE
				(MDA_MODELO = @V_Modelo OR CAST(MDA_ID AS VARCHAR) = @V_Modelo) AND
				MDA_ASSENTOS = @V_Assentos AND 
				MDA_FBA_ID = @V_IdFabricante AND
				MDA_TPI_ID = @V_IdIcao AND
				MDA_PMD_ID = @V_IdPMD AND
				MDA_TPA_ID = @V_IdTipoAeronave;

			UPDATE planilha_aeronave SET aeronave_modelo = @V_IdModeloAeronave WHERE aeronave_modelo = @V_Modelo;

			FETCH NEXT FROM
				CURSOR_MDA
			INTO
				@V_Modelo,
				@V_Assentos,
				@V_IdIcao,
				@V_IdPMD,
				@V_IdTipoAeronave,
				@V_IdFabricante;
		END;

	DEALLOCATE CURSOR_MDA;

END;
GO


--Procedure Aeronaves
CREATE PROCEDURE Proc_InserirAeronaves
AS
BEGIN
	DECLARE @V_Matricula VARCHAR(20);
	DECLARE @V_AnoFabricacao CHAR(4);
	DECLARE @V_IdModelo INT;
	DECLARE @V_IdQuantidadeMotores INT;
	DECLARE @V_IdTipoMotor INT;
	DECLARE @V_IdPais INT;
	DECLARE @V_IdARV INT ;
	DECLARE @V_Count INT;

	DECLARE CURSOR_ARV CURSOR FOR
	SELECT
		aeronave_matricula,
		aeronave_ano_fabricacao,
		CAST(aeronave_modelo AS INT),
		CAST(aeronave_motor_quantidade AS INT),
		CAST(aeronave_motor_tipo AS INT),
		CAST(aeronave_pais_fabricante AS INT)
	FROM
		planilha_aeronave;

	OPEN CURSOR_ARV;

	FETCH NEXT FROM
		CURSOR_ARV
	INTO
		@V_Matricula,
		@V_AnoFabricacao,
		@V_IdModelo,
		@V_IdQuantidadeMotores,
		@V_IdTipoMotor,
		@V_IdPais;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM 
				AERONAVES 
			WHERE
				ARV_MATRICULA = @V_Matricula AND
				ARV_ANO_FABRICACAO = @V_AnoFabricacao AND
				ARV_MDA_ID = @V_IdModelo AND
				ARV_TPM_ID = @V_IdTipoMotor AND
				ARV_QTM_ID = @V_IdQuantidadeMotores AND
				ARV_PAS_ID = @V_IdPais;

			IF @V_Count = 0
				BEGIN
					INSERT INTO AERONAVES(ARV_MATRICULA, ARV_ANO_FABRICACAO, ARV_MDA_ID, ARV_PAS_ID, ARV_QTM_ID, ARV_TPM_ID)
					VALUES (@V_Matricula, @V_AnoFabricacao, @V_IdModelo, @V_IdPais, @V_IdQuantidadeMotores, @V_IdTipoMotor);
				END;

			SELECT @V_IdARV = ARV_ID FROM 
				AERONAVES
			WHERE
				ARV_MATRICULA = @V_Matricula AND
				ARV_ANO_FABRICACAO = @V_AnoFabricacao AND
				ARV_MDA_ID = @V_IdModelo AND
				ARV_TPM_ID = @V_IdTipoMotor AND
				ARV_QTM_ID = @V_IdQuantidadeMotores AND
				ARV_PAS_ID = @V_IdPais;

			UPDATE planilha_aeronave SET aeronave_matricula = @V_IdARV WHERE aeronave_matricula = @V_Matricula;
			UPDATE planilha_aeronave SET aeronave_ano_fabricacao = @V_IdARV WHERE aeronave_ano_fabricacao = @V_AnoFabricacao;

			FETCH NEXT FROM
				CURSOR_ARV
			INTO
				@V_Matricula,
				@V_AnoFabricacao,
				@V_IdModelo,
				@V_IdQuantidadeMotores,
				@V_IdTipoMotor,
				@V_IdPais;

		END;

	DEALLOCATE CURSOR_ARV;

END;
GO

CREATE PROCEDURE Proc_InserirEstados
AS
BEGIN
	DECLARE @V_UF NVARCHAR(100);
	DECLARE @V_Count INT;
	DECLARE @V_IdEst INT;

	DECLARE CURSOR_EST CURSOR FOR
	SELECT
		ocorrencia_uf
	FROM
		planilha_ocorrencias;

	OPEN CURSOR_EST;

	FETCH NEXT FROM
		CURSOR_EST
	INTO
		@V_UF;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM
				ESTADOS
			WHERE EST_UF = @V_UF OR CAST(EST_ID AS nvarchar) = @V_UF;

			IF @V_Count = 0
				BEGIN
					INSERT INTO ESTADOS (EST_UF, EST_PAS_ID) VALUES ( @V_UF, (SELECT PAS_ID FROM PAISES WHERE PAS_NOME = 'BRASIL'));
				END;

			SELECT @V_IdEst = EST_ID  FROM ESTADOS WHERE EST_UF = @V_UF OR CAST(EST_ID AS nvarchar) = @V_UF;

			UPDATE planilha_ocorrencias SET ocorrencia_uf = @V_IdEst WHERE ocorrencia_uf = @V_UF;

			FETCH NEXT FROM
				CURSOR_EST
			INTO
				@V_UF;
		END;

	DEALLOCATE CURSOR_EST;

END;
GO

--Procedure Municipios
CREATE PROCEDURE Proc_InserirMunicipio
AS
BEGIN
	DECLARE @V_Municipio NVARCHAR(100);
	DECLARE @V_IdUF INT;
	DECLARE @V_Count INT;
	DECLARE @V_IdMuc INT;

	DECLARE CURSOR_MUC_OAC CURSOR FOR
	SELECT
		ISNULL(ocorrencia_cidade, 'NÃO IDENTIFICADO'),
		CAST(ocorrencia_uf AS INT)
	FROM
		planilha_ocorrencias;

	OPEN CURSOR_MUC_OAC;

	FETCH NEXT FROM
		CURSOR_MUC_OAC
	INTO
		@V_Municipio,
		@V_IdUF;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM 
				MUNICIPIOS 
			WHERE 
				(MUC_NOME = @V_Municipio OR CAST(MUC_ID AS NVARCHAR) = @V_Municipio) AND 
				MUC_EST_ID = @V_IdUF;

			IF @V_Count = 0
				BEGIN
					INSERT INTO MUNICIPIOS(MUC_NOME, MUC_EST_ID) VALUES
					(@V_Municipio, @V_IdUF);
				END;

			SELECT @V_IdMuc = MUC_ID FROM 
				MUNICIPIOS 
			WHERE 
				(MUC_NOME = @V_Municipio OR CAST(MUC_ID AS NVARCHAR) = @V_Municipio) AND
				MUC_EST_ID = @V_IdUF;


			UPDATE planilha_ocorrencias SET ocorrencia_cidade = @V_IdMuc WHERE ocorrencia_cidade = @V_Municipio AND ocorrencia_uf = @V_IdUF;

			FETCH NEXT FROM
				CURSOR_MUC_OAC
			INTO
				@V_Municipio,
				@V_IdUF;

		END;

	DEALLOCATE CURSOR_MUC_OAC;
END;
GO


--Proc inserir classificacao acidentes
CREATE PROCEDURE Proc_ClassificacaoAcidentes
AS
BEGIN								 
	DECLARE @V_Classificacao NVARCHAR(100);
	DECLARE @V_IdCLA INT;
	DECLARE @V_Count INT;

	DECLARE CURSOR_CLA CURSOR FOR
	SELECT				  
		ocorrencia_classificacao
	FROM
		planilha_ocorrencias;

	OPEN CURSOR_CLA;

	FETCH NEXT FROM
		CURSOR_CLA
	INTO
		@V_Classificacao;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM CLASSIFICACOES_ACIDENTES WHERE CLA_CLASSIFICACAO = @V_Classificacao OR CAST(CLA_ID AS NVARCHAR) = @V_Classificacao;

			IF @V_Count = 0
				BEGIN
					INSERT INTO CLASSIFICACOES_ACIDENTES(CLA_CLASSIFICACAO) VALUES (@V_Classificacao);
				END;

			SELECT @V_IdCla = CLA_ID FROM CLASSIFICACOES_ACIDENTES WHERE CLA_CLASSIFICACAO = @V_Classificacao OR CAST(CLA_ID AS NVARCHAR) = @V_Classificacao;

			UPDATE 	planilha_ocorrencias SET ocorrencia_classificacao = @V_IdCla WHERE ocorrencia_classificacao = @V_Classificacao;

				FETCH NEXT FROM
					CURSOR_CLA
				INTO
					@V_Classificacao;
		END;

	DEALLOCATE 	CURSOR_CLA;

END;
GO


--Proc Inserir aerodromos
CREATE PROCEDURE Proc_InserirAerodromos
AS
BEGIN
	DECLARE @V_Sigla NVARCHAR(100);
	DECLARE @V_IdARD INT;
	DECLARE @V_Count INT;

	DECLARE CURSOR_ARD CURSOR FOR
	SELECT
		ocorrencia_aerodromo
	FROM
		planilha_ocorrencias;

	OPEN CURSOR_ARD;

	FETCH NEXT FROM
		CURSOR_ARD
	INTO
		@V_Sigla;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM AERODROMOS WHERE ARD_SIGLA = @V_Sigla OR CAST(ARD_ID AS NVARCHAR) = @V_Sigla; 

			IF @V_Count = 0
				BEGIN
					INSERT INTO AERODROMOS(ARD_SIGLA) VALUES (@V_Sigla);
				END;

			SELECT @V_IdARD = ARD_Id FROM AERODROMOS WHERE ARD_SIGLA = @V_Sigla OR CAST(ARD_ID AS NVARCHAR) = @V_Sigla;

			UPDATE planilha_ocorrencias SET ocorrencia_aerodromo = @V_IdARD WHERE ocorrencia_aerodromo = @V_Sigla;

			FETCH NEXT FROM
				CURSOR_ARD
			INTO
				@V_Sigla;
		END;

	DEALLOCATE CURSOR_ARD;

END;
GO

--Proc Inserir Categoria Acidente
CREATE PROCEDURE Proc_InserirCategoriaOcorrencia
AS
BEGIN
	DECLARE @V_Categoria NVARCHAR(250);
	DECLARE @V_Sigla NVARCHAR(20);
	DECLARE @V_IdCAO INT;
	DECLARE	@V_Count INT;

	DECLARE CURSOR_CAO CURSOR FOR
	SELECT
		ocorrencia_tipo,
		taxonomia_tipo_icao
	FROM
		planilha_ocorrencia_tipo;

	OPEN CURSOR_CAO;

	FETCH NEXT FROM
		CURSOR_CAO
	INTO
		@V_Categoria,
		@V_Sigla;


	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM CATEGORIAS_OCORRENCIAS WHERE (CAO_CATEGORIA = @V_Categoria OR CAST(CAO_ID AS NVARCHAR) = @V_Categoria) AND  CAO_SIGLA = @V_Sigla;
		
			IF @V_Count = 0
				BEGIN
					INSERT INTO CATEGORIAS_OCORRENCIAS(CAO_CATEGORIA, CAO_SIGLA) VALUES (@V_Categoria, @V_Sigla);
				END;
			
			SELECT @V_IdCAO = CAO_ID FROM CATEGORIAS_OCORRENCIAS WHERE (CAO_CATEGORIA = @V_Categoria OR CAST(CAO_ID AS NVARCHAR) = @V_Categoria) AND  CAO_SIGLA = @V_Sigla;

			UPDATE planilha_ocorrencia_tipo SET ocorrencia_tipo =  @V_IdCAO WHERE ocorrencia_tipo = @V_Categoria;
			UPDATE planilha_ocorrencia_tipo SET taxonomia_tipo_icao =  @V_IdCAO WHERE taxonomia_tipo_icao = @V_Sigla;

			FETCH NEXT FROM
				CURSOR_CAO
			INTO
				@V_Categoria,
				@V_Sigla;

		END;

	DEALLOCATE CURSOR_CAO;

END;
GO

--Proc Inserir  Ocorrencias
CREATE PROCEDURE Proc_InserirOcorrencias
AS
BEGIN
	DECLARE @V_Codigo NVARCHAR(20);
	DECLARE @V_Latitude NVARCHAR(100);
	DECLARE @V_Longitude NVARCHAR(100);
	DECLARE @V_DIA DATE;
	DECLARE @V_Horario TIME;
	DECLARE @V_Total_Aeronaves INT;
	DECLARE @V_Fatalidades INT;
	DECLARE @V_Saida_Pista CHAR(3);
	DECLARE @V_IdARV INT;
	DECLARE @V_IdMUC INT;
	DECLARE @V_IdARD INT;
	DECLARE @V_IdTPS INT;
	DECLARE @V_IdCAO INT;
	DECLARE @V_IdCLA INT;
	DECLARE @V_IdNVA INT;
	DECLARE @V_IdOAC INT;
	DECLARE @V_Count INT;

	DECLARE CURSOR_OAC CURSOR FOR
	SELECT 
		OAC.codigo_ocorrencia,
		OAC.ocorrencia_latitude,
		OAC.ocorrencia_longitude,
		CAST(OAC.ocorrencia_dia AS DATE),
		CASE 
			WHEN OAC.ocorrencia_hora = 'NULL' THEN CAST('00:00:00' AS TIME)
			ELSE CAST(OAC.ocorrencia_hora AS TIME)
		END,
		OAC.total_aeronaves_envolvidas,
		ARV.aeronave_fatalidades_total,
		OAC.ocorrencia_saida_pista,
		CAST(ARV.aeronave_matricula AS INT),
		CAST(OAC.ocorrencia_cidade AS INT),
		CAST(OAC.ocorrencia_aerodromo AS INT),
		CAST(ARV.aeronave_registro_segmento AS INT),
		CAST(OTP.ocorrencia_tipo AS INT),
		CAST(OAC.ocorrencia_classificacao AS INT),
		CAST(ARV.aeronave_nivel_dano AS INT)
	FROM planilha_ocorrencias OAC
	JOIN planilha_aeronave ARV ON OAC.codigo_ocorrencia = arv.codigo_ocorrencia2
	JOIN planilha_ocorrencia_tipo OTP ON OAC.codigo_ocorrencia = OTP.codigo_ocorrencia1;

	OPEN CURSOR_OAC;

	FETCH NEXT FROM
		CURSOR_OAC
	INTO
		@V_Codigo,
		@V_Latitude,
		@V_Longitude,
		@V_DIA,
		@V_Horario,
		@V_Total_Aeronaves,
		@V_Fatalidades,
		@V_Saida_Pista,
		@V_IdARV,
		@V_IdMUC,
		@V_IdARD,
		@V_IdTPS,
		@V_IdCAO,
		@V_IdCLA,
		@V_IdNVA;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM OCORRENCIAS_AERONAVES WHERE OAC_CODIGO = @V_Codigo;

			IF @V_Count = 0
				BEGIN
					INSERT INTO OCORRENCIAS_AERONAVES(OAC_CODIGO, OAC_LATITUDE, OAC_LONGITUTDE, OAC_DIA, OAC_HORARIO, OAC_TOTAL_AERONAVES, OAC_FATALIDADE ,OAC_SAIDA_PISTA, OAC_ARV_ID, OAC_MUC_ID, OAC_ARD_ID, OAC_TPS_ID, OAC_CAO_ID, OAC_CLA_ID, OAC_NVA_ID)
					VALUES (@V_Codigo, @V_Latitude, @V_Longitude, @V_DIA, @V_Horario, @V_Total_Aeronaves, @V_Fatalidades, @V_Saida_Pista, @V_IdARV, @V_IdMUC, @V_IdARD, @V_IdTPS, @V_IdCAO, @V_IdCLA, @V_IdNVA);
				END;

			SELECT @V_IdOAC = OAC_ID FROM OCORRENCIAS_AERONAVES WHERE OAC_CODIGO = @V_Codigo;

			UPDATE planilha_ocorrencias SET codigo_ocorrencia = @V_IdOAC WHERE codigo_ocorrencia = @V_Codigo;

			FETCH NEXT FROM
				CURSOR_OAC
			INTO
				@V_Codigo,
				@V_Latitude,
				@V_Longitude,
				@V_DIA,
				@V_Horario,
				@V_Total_Aeronaves,
				@V_Fatalidades,
				@V_Saida_Pista,
				@V_IdARV,
				@V_IdMUC,
				@V_IdARD,
				@V_IdTPS,
				@V_IdCAO,
				@V_IdCLA,
				@V_IdNVA;

		END;

	DEALLOCATE CURSOR_OAC;

END;
GO


--Proc inserir tipo de falha
CREATE PROCEDURE Proc_InserirTIposFalhas
AS
BEGIN
	DECLARE @V_Tipo NVARCHAR(100);
	DECLARE @V_Count INT;
	DECLARE @V_IdTPF INT;

	DECLARE CURSOR_TPF CURSOR FOR
	SELECT
		fator_area
	FROM
		planilha_fator_contribuinte;

	OPEN CURSOR_TPF;

	FETCH NEXT FROM
		CURSOR_TPF
	INTO
		@V_Tipo;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM TIPOS_FALHAS WHERE TPF_TIPO = @V_Tipo OR CAST(TPF_ID AS NVARCHAR) = @V_Tipo;

			IF @V_Count = 0
				BEGIN
					INSERT INTO TIPOS_FALHAS(TPF_TIPO) VALUES (@V_Tipo);
				END;

			SELECT @V_IdTPF = TPF_ID FROM TIPOS_FALHAS WHERE TPF_TIPO = @V_Tipo OR CAST(TPF_ID AS NVARCHAR) = @V_Tipo;

			UPDATE planilha_fator_contribuinte SET fator_area = @V_IdTPF WHERE fator_area = @V_Tipo;

			FETCH NEXT FROM
				CURSOR_TPF
			INTO
				@V_Tipo;
		END;

	DEALLOCATE CURSOR_TPF;

END;
GO

--Proc inserir Condicionantes Acidentes
CREATE PROCEDURE Proc_InserirCondicionantesAcidentes
AS
BEGIN
	DECLARE @V_Condiciconante NVARCHAR(100);
	DECLARE @V_Count INT;
	DECLARE @V_IdCDA INT;

	DECLARE CURSOR_CDA CURSOR FOR
	SELECT
		fator_condicionante
	FROM
		planilha_fator_contribuinte;

	OPEN CURSOR_CDA;

	FETCH NEXT FROM
		CURSOR_CDA
	INTO
		@V_Condiciconante;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM CONDICIONANTES_ACIDENTES WHERE CDA_CONDICIONANTE = @V_Condiciconante or CAST(CDA_ID AS NVARCHAR) = @V_Condiciconante;

			IF @V_Count = 0
				BEGIN
					INSERT INTO CONDICIONANTES_ACIDENTES (CDA_CONDICIONANTE) VALUES (@V_Condiciconante);
				END;

			SELECT @V_IdCDA = CDA_ID FROM CONDICIONANTES_ACIDENTES WHERE CDA_CONDICIONANTE = @V_Condiciconante or CAST(CDA_ID AS NVARCHAR) = @V_Condiciconante;

			UPDATE planilha_fator_contribuinte SET fator_condicionante = @V_IdCDA WHERE fator_condicionante = @V_Condiciconante;

			FETCH NEXT FROM
				CURSOR_CDA
			INTO
				@V_Condiciconante;
		END;

	DEALLOCATE CURSOR_CDA;

END;
GO

--Proc inserir Aspectos Acidentes
CREATE PROCEDURE Proc_InserirAspectosAcidentes
AS
BEGIN
	DECLARE @V_Aspecto NVARCHAR(100);
	DECLARE @V_Count INT;
	DECLARE @V_IdAAS INT;

	DECLARE CURSOR_AAS CURSOR FOR
	SELECT
		fator_aspecto
	FROM
		planilha_fator_contribuinte;

	OPEN CURSOR_AAS;

	FETCH NEXT FROM
		CURSOR_AAS
	INTO
		@V_Aspecto;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM ASPECTOS_ACIDENTES WHERE AAS_ASPECTO = @V_Aspecto or CAST(AAS_ID AS NVARCHAR) = @V_Aspecto;

			IF @V_Count = 0
				BEGIN
					INSERT INTO ASPECTOS_ACIDENTES (AAS_ASPECTO) VALUES (@V_Aspecto);
				END;

			SELECT @V_IdAAS = AAS_ID FROM ASPECTOS_ACIDENTES WHERE AAS_ASPECTO = @V_Aspecto or CAST(AAS_ID AS NVARCHAR) = @V_Aspecto;

			UPDATE planilha_fator_contribuinte SET fator_aspecto = @V_IdAAS WHERE fator_aspecto = @V_Aspecto;

			FETCH NEXT FROM
				CURSOR_AAS
			INTO
				@V_Aspecto;
		END;

	DEALLOCATE CURSOR_AAS;

END;
GO
	
--Proc inserir Condicionantes Acidentes
CREATE PROCEDURE Proc_InserirFatoresAcidentes
AS
BEGIN
	DECLARE @V_Fator NVARCHAR(100);
	DECLARE @V_Count INT;
	DECLARE @V_IdFAC INT;

	DECLARE CURSOR_FAC CURSOR FOR
	SELECT
		fator_nome
	FROM
		planilha_fator_contribuinte;

	OPEN CURSOR_FAC;

	FETCH NEXT FROM
		CURSOR_FAC
	INTO
		@V_Fator;

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @V_Count = COUNT(*) FROM FATORES_ACIDENTES WHERE FAC_NOME = @V_Fator or CAST(FAC_ID AS NVARCHAR) = @V_Fator;

			IF @V_Count = 0
				BEGIN
					INSERT INTO FATORES_ACIDENTES (FAC_NOME) VALUES (@V_Fator);
				END;

			SELECT @V_IdFAC = FAC_ID FROM FATORES_ACIDENTES WHERE FAC_NOME = @V_Fator or CAST(FAC_ID AS NVARCHAR) = @V_Fator;

			UPDATE planilha_fator_contribuinte SET fator_nome = @V_IdFAC WHERE fator_nome = @V_Fator;

			FETCH NEXT FROM
				CURSOR_FAC
			INTO
				@V_Fator;
		END;

	DEALLOCATE CURSOR_FAC;

END;
GO


--Proc Inserir Investigações
CREATE PROCEDURE Proc_InserirInvestigacoes
AS
BEGIN
	DECLARE @V_Status NVARCHAR(100);
	DECLARE @V_IdOAC INT;
	DECLARE @V_IdTPF INT;
	DECLARE @V_IdAAS INT;
	DECLARE @V_IdCDA INT;
	DECLARE @V_IdFAC INT;
	DECLARE @V_Count INT;

	DECLARE CURSOR_IVA CURSOR FOR
	SELECT 
		OAC.investigacao_status, 
		ORV.OAC_ID, 
		TPF.TPF_ID, 
		AAS.AAS_ID,
		CDA.CDA_ID, 
		FAC.FAC_ID  
	FROM planilha_fator_contribuinte FCT        
	JOIN planilha_ocorrencias OAC ON OAC.codigo_ocorrencia3 = FCT.codigo_ocorrencia3
	JOIN OCORRENCIAS_AERONAVES ORV ON OAC.codigo_ocorrencia = CAST(ORV.OAC_ID AS NVARCHAR)
	JOIN TIPOS_FALHAS TPF ON FCT.fator_area = CAST(TPF.TPF_ID AS NVARCHAR)
	JOIN CONDICIONANTES_ACIDENTES CDA ON FCT.fator_condicionante = CAST(CDA.CDA_ID AS NVARCHAR)
	JOIN ASPECTOS_ACIDENTES AAS ON FCT.fator_aspecto = CAST(AAS.AAS_ID AS NVARCHAR)
	JOIN FATORES_ACIDENTES FAC ON FCT.fator_nome = CAST(FAC.FAC_ID AS NVARCHAR);

	OPEN CURSOR_IVA;

	FETCH NEXT FROM
		CURSOR_IVA
	INTO
		@V_Status,
		@V_IdOAC,
		@V_IdTPF,
		@V_IdAAS,
		@V_IdCDA,
		@V_IdFAC

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT 
				@V_Count = COUNT(*) 
			FROM 
				INVESTIGACOES_ACIDENTES
			WHERE
				IVA_STATUS = @V_Status AND
				IVA_OAC_ID = @V_IdOAC AND
				IVA_TPF_ID = @V_IdTPF AND
				IVA_AAS_ID = @V_IdAAS AND
				IVA_CDA_ID = @V_IdCDA AND
				IVA_FAC_ID = @V_IdFAC

			IF @V_Count = 0
				BEGIN
					INSERT INTO INVESTIGACOES_ACIDENTES (IVA_STATUS, IVA_OAC_ID, IVA_TPF_ID, IVA_AAS_ID, IVA_CDA_ID, IVA_FAC_ID) VALUES (@V_Status, @V_IdOAC, @V_IdTPF, @V_IdAAS, @V_IdCDA, @V_IdFAC);
				END;

				FETCH NEXT FROM
					CURSOR_IVA
				INTO
					@V_Status,
					@V_IdOAC,
					@V_IdTPF,
					@V_IdAAS,
					@V_IdCDA,
					@V_IdFAC
		END;
		
	DEALLOCATE CURSOR_IVA;

END;
GO

--PROCEDURE PARA DISTRIBUIÇÃO
CREATE PROCEDURE DistribuirDados
AS
BEGIN
			--TABELAS SEM FKs--

			--Normalizar paises
			EXEC Proc_InserirPaises ;

			--Normalizar Tipo Icao
			EXEC Proc_InserirTipoIcao ;

			--Normalizar Peso maximo decolagem /PMD
			EXEC Proc_InserirPMD;

			--Normalizar Tipo de aeronave
			EXEC Proc_InserirTipoAeronave;

			--Normalizar Fabricantes
			EXEC Proc_InserirFabricanteAeronave;

			--Normalizar tipo de motores
			EXEC Proc_InserirTipoMotores;

			--Normalizar quantidade motores
			EXEC Proc_InseririQuantidadeMotores;
														     
			--Nornmalizar niveis danos acidentes
			EXEC Proc_InserirNiveisDados;

			--Normalizar tipos segmentos
			EXEC Proc_InserirTiposSegmentos;

			--Normalizar Classificacao acidente
			EXEC Proc_ClassificacaoAcidentes;

			--Normalizar Aerodromos
			EXEC Proc_InserirAerodromos;

			--Normalizar Caegorias Ocorrencias;
			EXEC Proc_InserirCategoriaOcorrencia;
			
			--Normalizar Tipo de falhas;
			EXEC Proc_InserirTIposFalhas;

			--Normalizar Condicionantes Acidentes
			EXEC Proc_InserirCondicionantesAcidentes;

			--Normalizar Aspectos Acidentes
			EXEC Proc_InserirAspectosAcidentes;

			--Normalizar Fatores Acidentes
			EXEC Proc_InserirFatoresAcidentes;


			--TABELAS COM FKs--
			--Normalizar modelos aeronaves
			EXEC Proc_InserirModelosAeronaves;

			--Normalizar aeronaves
			EXEC Proc_InserirAeronaves;

			--Normalizar Estados
			EXEC Proc_InserirEstados;

			--Normalizar Municipios
			EXEC Proc_InserirMunicipio;

			--Normalizar Ocorrencias
			EXEC Proc_InserirOcorrencias;

			--Normalizer Investigações
			EXEC Proc_InserirInvestigacoes;

END;
GO