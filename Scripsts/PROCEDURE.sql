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



--PROCEDURE PARA DISTRUIBIÇÃO
CREATE PROCEDURE DistribuirDadosAeronave
AS
BEGIN
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

			--Normalizar modelos aeronaves
			EXEC Proc_InserirModelosAeronaves;
END
GO