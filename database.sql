PGDMP     9                    z           nodejs    12.10    12.10 f    ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    32801    nodejs    DATABASE     d   CREATE DATABASE nodejs WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';
    DROP DATABASE nodejs;
                postgres    false            ?            1255    32802    cat_contribuyentes_vw_dml()    FUNCTION     s
  CREATE FUNCTION public.cat_contribuyentes_vw_dml() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
      IF TG_OP = 'INSERT' THEN
        IF NEW.flag_sin_beneficios IS NULL THEN
            NEW.flag_sin_beneficios=0;
        end if;
        INSERT INTO cat_contribuyentes (rfc, curp, regimen_fiscal, nombre, ap_paterno, ap_materno, nombre_completo, nacimiento_fecha, nacimiento_estado, nacimiento_ciudad, sexo, dom_calle, dom_no_exterior, dom_letra, dom_no_interior, dom_colonia, dom_referencia, dom_cp, dom_localidad, dom_ciudad, dom_estado, dom_pais, email, telefono, celular, agregadopor, flag_sin_beneficios)
             VALUES(NEW.rfc, NEW.curp, NEW.regimen_fiscal, NEW.nombre, NEW.ap_paterno, NEW.ap_materno, trim(CONCAT(NEW.ap_paterno, ' ' , NEW.ap_materno, ' ', NEW.nombre)), NEW.nacimiento_fecha, NEW.nacimiento_estado, NEW.nacimiento_ciudad, NEW.sexo, NEW.dom_calle, NEW.dom_no_exterior, NEW.dom_letra, NEW.dom_no_interior, NEW.dom_colonia, NEW.dom_referencia, NEW.dom_cp, NEW.dom_localidad, NEW.dom_ciudad, (select id_estado from vw_cat_ciudades where id_municipio=NEW.dom_ciudad), (select id_pais from vw_cat_ciudades where id_municipio=NEW.dom_ciudad), NEW.email, NEW.telefono, NEW.celular, NEW.agregadopor, NEW.flag_sin_beneficios)
        RETURNING id_contribuyente INTO NEW.id_contribuyente;
        RETURN NEW;
      ELSIF TG_OP = 'UPDATE' THEN
       IF NEW.flag_sin_beneficios IS NULL THEN
           NEW.flag_sin_beneficios=0;
       end if;
       UPDATE cat_contribuyentes SET rfc=NEW.rfc, curp=NEW.curp, regimen_fiscal=NEW.regimen_fiscal, nombre=NEW.nombre, ap_paterno=NEW.ap_paterno, ap_materno=NEW.ap_materno, nombre_completo=trim(CONCAT(NEW.ap_paterno, ' ' , NEW.ap_materno, ' ', NEW.nombre)), nacimiento_fecha=NEW.nacimiento_fecha, nacimiento_estado=NEW.nacimiento_estado, nacimiento_ciudad=NEW.nacimiento_ciudad, sexo=NEW.sexo, dom_calle=NEW.dom_calle, dom_no_exterior=NEW.dom_no_exterior, dom_letra=NEW.dom_letra, dom_no_interior=NEW.dom_no_interior, dom_colonia=NEW.dom_colonia, dom_referencia=NEW.dom_referencia, dom_cp=NEW.dom_cp, dom_localidad=NEW.dom_localidad, dom_ciudad=NEW.dom_ciudad, dom_estado=(select id_estado from vw_cat_ciudades where id_municipio=NEW.dom_ciudad), dom_pais=(select id_pais from vw_cat_ciudades where id_municipio=NEW.dom_ciudad), email=NEW.email, telefono=NEW.telefono, celular=NEW.celular, status=NEW.status, flag_sin_beneficios=NEW.flag_sin_beneficios WHERE id_contribuyente=OLD.id_contribuyente;
       RETURN NEW;
      ELSIF TG_OP = 'DELETE' THEN
       UPDATE cat_contribuyentes SET status=0 WHERE id_contribuyente=OLD.id_contribuyente;
       RETURN NULL;
      END IF;
      RETURN NEW;
    END;
$$;
 2   DROP FUNCTION public.cat_contribuyentes_vw_dml();
       public          postgres    false            ?            1255    32803 !   cat_ctas_contables_saacg_vw_dml()    FUNCTION     ?  CREATE FUNCTION public.cat_ctas_contables_saacg_vw_dml() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
      IF TG_OP = 'INSERT' THEN
        INSERT INTO cat_ctas_contables_saacg (anio, cuenta_contable, nombre_cuenta, descripcion, agregadopor, fechaagregado, status)
             VALUES(NEW.anio, NEW.cuenta_contable, NEW.nombre_cuenta, NEW.descripcion, NEW.agregadopor, NEW.fechaagregado, NEW.status)
        RETURNING id_cta_contable INTO NEW.id_cta_contable;
        RETURN NEW;
      ELSIF TG_OP = 'UPDATE' THEN
       UPDATE cat_ctas_contables_saacg SET anio=NEW.anio, cuenta_contable=NEW.cuenta_contable, nombre_cuenta=NEW.nombre_cuenta, descripcion=NEW.descripcion, status=NEW.status WHERE id_cta_contable=OLD.id_cta_contable;
       RETURN NEW;
      ELSIF TG_OP = 'DELETE' THEN
       UPDATE cat_ctas_contables_saacg SET status=0 WHERE id_cta_contable=OLD.id_cta_contable;
       RETURN NULL;
      END IF;
      RETURN NEW;
    END;
$$;
 8   DROP FUNCTION public.cat_ctas_contables_saacg_vw_dml();
       public          postgres    false            ?            1255    32804    cat_ingresos_clase_vw_dml()    FUNCTION     u  CREATE FUNCTION public.cat_ingresos_clase_vw_dml() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
      IF TG_OP = 'INSERT' THEN
        INSERT INTO cat_ingresos_clase (id_ingreso, clase_ingreso, descripcion, agregadopor, fechaagregado, status)
             VALUES(NEW.id_ingreso, NEW.clase_ingreso, NEW.descripcion, NEW.agregadopor, NEW.fechaagregado, NEW.status)
        RETURNING id_clase_ingreso INTO NEW.id_clase_ingreso;
        RETURN NEW;
      ELSIF TG_OP = 'UPDATE' THEN
       UPDATE cat_ingresos_clase SET id_ingreso=NEW.id_ingreso, clase_ingreso=NEW.clase_ingreso, descripcion=NEW.descripcion, status=NEW.status WHERE id_clase_ingreso=OLD.id_clase_ingreso;
       RETURN NEW;
      ELSIF TG_OP = 'DELETE' THEN
       UPDATE cat_ingresos_clase SET status=0 WHERE id_clase_ingreso=OLD.id_clase_ingreso;
       RETURN NULL;
      END IF;
      RETURN NEW;
    END;
$$;
 2   DROP FUNCTION public.cat_ingresos_clase_vw_dml();
       public          postgres    false            ?            1255    32805 *   cat_ingresos_concepto_recaudacion_vw_dml()    FUNCTION     ?  CREATE FUNCTION public.cat_ingresos_concepto_recaudacion_vw_dml() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
      IF TG_OP = 'INSERT' THEN
        INSERT INTO  cat_ingresos_concepto_recaudacion
        (anio, id_cve_contrib, concepto_recaudacion, descripcion, cve_traslanet, etiqueta_base_cobro, porcentaje, fraccion_uma, limite_inf, limite_sup, tipo_calculo, agregadopor, fechaagregado, status, es_descuento, cta_contable_corriente, cta_contable_rezago)
        VALUES(NEW.anio, NEW.id_cve_contrib, NEW.concepto_recaudacion, NEW.descripcion, NEW.cve_traslanet, NEW.etiqueta_base_cobro, NEW.porcentaje, NEW.fraccion_uma, NEW.limite_inf, NEW.limite_sup, NEW.tipo_calculo, NEW.agregadopor, NEW.fechaagregado, NEW.status, NEW.es_descuento, NEW.cuenta_contable, NEW.cuenta_contable_rezago)
        RETURNING id_concepto_recaudacion INTO NEW.id_concepto_recaudacion;
        RETURN NEW;
      ELSIF TG_OP = 'UPDATE' THEN
       UPDATE cat_ingresos_concepto_recaudacion SET anio=NEW.anio, id_cve_contrib=NEW.id_cve_contrib, concepto_recaudacion=NEW.concepto_recaudacion, descripcion=NEW.descripcion, cve_traslanet=NEW.cve_traslanet, etiqueta_base_cobro=NEW.etiqueta_base_cobro, porcentaje=NEW.porcentaje, fraccion_uma=NEW.fraccion_uma, limite_inf=NEW.limite_inf, limite_sup=NEW.limite_sup, tipo_calculo=NEW.tipo_calculo, status=NEW.status, es_descuento=NEW.es_descuento, cta_contable_corriente=NEW.cuenta_contable, cta_contable_rezago=NEW.cuenta_contable_rezago WHERE id_concepto_recaudacion=OLD.id_concepto_recaudacion;
       RETURN NEW;
      ELSIF TG_OP = 'DELETE' THEN
       UPDATE cat_ingresos_concepto_recaudacion SET status=0 WHERE id_concepto_recaudacion=OLD.id_concepto_recaudacion;
       RETURN NULL;
      END IF;
      RETURN NEW;
    END;
$$;
 A   DROP FUNCTION public.cat_ingresos_concepto_recaudacion_vw_dml();
       public          postgres    false            ?            1255    32806 '   cat_ingresos_cves_contribucion_vw_dml()    FUNCTION     ?  CREATE FUNCTION public.cat_ingresos_cves_contribucion_vw_dml() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
      IF TG_OP = 'INSERT' THEN
        INSERT INTO cat_ingresos_cves_contribucion (id_clase_ingreso, cve_contribucion, descripcion, agregadopor, fechaagregado, status)
             VALUES(NEW.id_clase_ingreso, NEW.cve_contribucion, NEW.descripcion, NEW.agregadopor, NEW.fechaagregado, NEW.status)
        RETURNING id_cve_contribucion INTO NEW.id_cve_contribucion;
        RETURN NEW;
      ELSIF TG_OP = 'UPDATE' THEN
       UPDATE cat_ingresos_cves_contribucion SET id_clase_ingreso=NEW.id_clase_ingreso, cve_contribucion=NEW.cve_contribucion, descripcion=NEW.descripcion, status=NEW.status WHERE id_cve_contribucion=OLD.id_cve_contribucion;
       RETURN NEW;
      ELSIF TG_OP = 'DELETE' THEN
       UPDATE cat_ingresos_cves_contribucion SET status=0 WHERE id_cve_contribucion=OLD.id_cve_contribucion;
       RETURN NULL;
      END IF;
      RETURN NEW;
    END;
$$;
 >   DROP FUNCTION public.cat_ingresos_cves_contribucion_vw_dml();
       public          postgres    false            ?            1255    32807    cat_ingresos_fuentes_vw_dml()    FUNCTION     J  CREATE FUNCTION public.cat_ingresos_fuentes_vw_dml() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE vId_Config int;
BEGIN
      IF TG_OP = 'INSERT' THEN
        INSERT INTO  cat_ingresos_fuente
        (anio, id_cve_contrib, fuente_ingreso, descripcion, cve_traslanet, etiqueta_base_cobro, porcentaje, fraccion_uma, limite_inf, limite_sup, tipo_calculo, id_cta_contable, id_cta_contable_rezago, agregadopor, fechaagregado, status)
        VALUES(NEW.anio, NEW.id_cve_contrib, NEW.fuente_ingreso, NEW.descripcion, NEW.cve_traslanet, NEW.etiqueta_base_cobro, NEW.porcentaje, NEW.fraccion_uma, NEW.limite_inf, NEW.limite_sup, NEW.tipo_calculo, NEW.id_cta_contable, NEW.id_cta_contable_rezago, NEW.agregadopor, NEW.fechaagregado, NEW.status)
        RETURNING id_fuente_ingreso INTO NEW.id_fuente_ingreso;

        SELECT id_ctas_contables_fuentes into vId_Config FROM config_ctas_contables_fuentes WHERE status=1 and fuente_ingreso=concat(f_get_clave_contribucion(NEW.id_cve_contrib),'.',NEW.fuente_ingreso);
        IF vId_Config IS NULL THEN
            INSERT INTO config_ctas_contables_fuentes(fuente_ingreso, cta_contable_corriente, cta_contable_rezago, agregadopor, fechaagregado) VALUES (concat(f_get_clave_contribucion(NEW.id_cve_contrib),'.',NEW.fuente_ingreso), NEW.id_cta_contable, NEW.id_cta_contable_rezago, NEW.agregadopor, NEW.fechaagregado);
        ELSE
            UPDATE config_ctas_contables_fuentes SET cta_contable_corriente=NEW.id_cta_contable, cta_contable_rezago=NEW.id_cta_contable_rezago WHERE id_ctas_contables_fuentes=vId_Config;
        end if;

        RETURN NEW;
      ELSIF TG_OP = 'UPDATE' THEN
       UPDATE cat_ingresos_fuente SET anio=NEW.anio, id_cve_contrib=NEW.id_cve_contrib, fuente_ingreso=NEW.fuente_ingreso, descripcion=NEW.descripcion, cve_traslanet=NEW.cve_traslanet, etiqueta_base_cobro=NEW.etiqueta_base_cobro, porcentaje=NEW.porcentaje, fraccion_uma=NEW.fraccion_uma, limite_inf=NEW.limite_inf, limite_sup=NEW.limite_sup, tipo_calculo=NEW.tipo_calculo, id_cta_contable=NEW.id_cta_contable, id_cta_contable_rezago=NEW.id_cta_contable_rezago, status=NEW.status WHERE id_fuente_ingreso=OLD.id_fuente_ingreso;

       SELECT id_ctas_contables_fuentes into vId_Config FROM config_ctas_contables_fuentes WHERE status=1 and fuente_ingreso=concat(f_get_clave_contribucion(NEW.id_cve_contrib),'.',NEW.fuente_ingreso);
        IF vId_Config IS NULL THEN
            INSERT INTO config_ctas_contables_fuentes(fuente_ingreso, cta_contable_corriente, cta_contable_rezago, agregadopor, fechaagregado) VALUES (concat(f_get_clave_contribucion(NEW.id_cve_contrib),'.',NEW.fuente_ingreso), NEW.id_cta_contable, NEW.id_cta_contable_rezago, NEW.agregadopor, NEW.fechaagregado);
        ELSE
            UPDATE config_ctas_contables_fuentes SET cta_contable_corriente=NEW.id_cta_contable, cta_contable_rezago=NEW.id_cta_contable_rezago WHERE id_ctas_contables_fuentes=vId_Config;
        end if;
       RETURN NEW;
      ELSIF TG_OP = 'DELETE' THEN
       UPDATE cat_ingresos_fuente SET status=0 WHERE id_fuente_ingreso=OLD.id_fuente_ingreso;
       RETURN NULL;
      END IF;
      RETURN NEW;
    END;
$$;
 4   DROP FUNCTION public.cat_ingresos_fuentes_vw_dml();
       public          postgres    false            ?            1255    32808 $   cat_ingresos_liga_conceptos_vw_dml()    FUNCTION     ?  CREATE FUNCTION public.cat_ingresos_liga_conceptos_vw_dml() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
 IF TG_OP = 'INSERT' THEN
 INSERT INTO cat_ingresos_liga_conceptos
 (id_tipo_liga, anio, id_concepto_recaudacion_padre,
id_concepto_recaudacion_hijo, observaciones, obligatorio, estado_inicial,
fecha_inicio, fecha_fin, agregadopor, fechaagregado, status )
VALUES(new.id_tipo_liga, NEW.anio, NEW.id_concepto_recaudacion_padre,
NEW.id_concepto_recaudacion_hijo, NEW.observaciones, NEW.obligatorio,
NEW.estado_inicial, TO_DATE(NEW.fecha_inicio,'YYYY-MM-DD') ,
TO_DATE(NEW.fecha_fin,'YYYY-MM-DD'), NEW.agregadopor, NEW.fechaagregado,
NEW.status)
 RETURNING id_liga_concepto INTO NEW.id_liga_concepto;
 RETURN NEW;
 ELSIF TG_OP = 'UPDATE' THEN
 UPDATE cat_ingresos_liga_conceptos SET id_tipo_liga=NEW.id_tipo_liga,
anio=NEW.anio,
id_concepto_recaudacion_padre=NEW.id_concepto_recaudacion_padre,
id_concepto_recaudacion_hijo=NEW.id_concepto_recaudacion_hijo,
observaciones=NEW.observaciones, obligatorio=NEW.obligatorio,
estado_inicial=NEW.estado_inicial,
fecha_inicio=TO_DATE(NEW.fecha_inicio,'YYYY-MM-DD'),
fecha_fin=TO_DATE(NEW.fecha_fin,'YYYY-MM-DD'), status=NEW.status WHERE
id_liga_concepto=OLD.id_liga_concepto;
 RETURN NEW;
 ELSIF TG_OP = 'DELETE' THEN
 UPDATE cat_ingresos_liga_conceptos SET status=0 WHERE
id_liga_concepto=OLD.id_liga_concepto;
 RETURN NULL;
 END IF;
 RETURN NEW;
 END;
$$;
 ;   DROP FUNCTION public.cat_ingresos_liga_conceptos_vw_dml();
       public          postgres    false            ?            1255    32809    cat_ingresos_vw_dml()    FUNCTION     i  CREATE FUNCTION public.cat_ingresos_vw_dml() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
      IF TG_OP = 'INSERT' THEN
        INSERT INTO cat_ingresos (cve_ingreso, descripcion, id_clasificacion_ingreso, agregadopor, fechaagregado, status)
             VALUES(NEW.cve_ingreso, NEW.descripcion, NEW.id_clasificacion_ingreso, NEW.agregadopor, NEW.fechaagregado, NEW.status)
        RETURNING id_ingreso INTO NEW.id_ingreso;
        RETURN NEW;
      ELSIF TG_OP = 'UPDATE' THEN
       UPDATE cat_ingresos SET cve_ingreso=NEW.cve_ingreso, descripcion=NEW.descripcion, id_clasificacion_ingreso=NEW.id_clasificacion_ingreso, status=NEW.status WHERE id_ingreso=OLD.id_ingreso;
       RETURN NEW;
      ELSIF TG_OP = 'DELETE' THEN
       UPDATE cat_ingresos SET status=0 WHERE id_ingreso=OLD.id_ingreso;
       RETURN NULL;
      END IF;
      RETURN NEW;
    END;
$$;
 ,   DROP FUNCTION public.cat_ingresos_vw_dml();
       public          postgres    false            ?            1255    32810    cat_lic_alcoholes_vw_dml()    FUNCTION     ?  CREATE FUNCTION public.cat_lic_alcoholes_vw_dml() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
      IF TG_OP = 'INSERT' THEN
        INSERT INTO cat_lic_alcoholes (venta_alcoholes, agregadopor, fechaagregado, status)
             VALUES(NEW.venta_alcoholes, NEW.agregadopor, NEW.fechaagregado, NEW.status)
        RETURNING id_alcoholes INTO NEW.id_alcoholes;
        RETURN NEW;
      ELSIF TG_OP = 'UPDATE' THEN
       UPDATE cat_lic_alcoholes SET venta_alcoholes=NEW.venta_alcoholes, status=NEW.status WHERE id_alcoholes=OLD.id_alcoholes;
       RETURN NEW;
      ELSIF TG_OP = 'DELETE' THEN
       UPDATE cat_lic_alcoholes SET status=0 WHERE id_alcoholes=OLD.id_alcoholes;
       RETURN NULL;
      END IF;
      RETURN NEW;
    END;
$$;
 1   DROP FUNCTION public.cat_lic_alcoholes_vw_dml();
       public          postgres    false            ?            1255    32811    cat_lic_giros_vw_dml()    FUNCTION     ?  CREATE FUNCTION public.cat_lic_giros_vw_dml() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
      IF TG_OP = 'INSERT' THEN
        INSERT INTO cat_lic_giros (giro, agregadopor, fechaagregado, status, sare)
             VALUES(NEW.giro, NEW.agregadopor, NEW.fechaagregado, NEW.status, NEW.sare)
        RETURNING id_giro INTO NEW.id_giro;
        RETURN NEW;
      ELSIF TG_OP = 'UPDATE' THEN
       UPDATE cat_lic_giros SET giro=NEW.giro, status=NEW.status, sare=NEW.sare WHERE id_giro=OLD.id_giro;
       RETURN NEW;
      ELSIF TG_OP = 'DELETE' THEN
       UPDATE cat_lic_giros SET status=0 WHERE id_giro=OLD.id_giro;
       RETURN NULL;
      END IF;
      RETURN NEW;
    END;
$$;
 -   DROP FUNCTION public.cat_lic_giros_vw_dml();
       public          postgres    false            ?            1255    32812    cat_usuarios_vw_dml()    FUNCTION     c  CREATE FUNCTION public.cat_usuarios_vw_dml() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
      IF TG_OP = 'INSERT' THEN
        INSERT INTO usuarios (nombre_completo, email, rfc, telefono, celular, password, tipo, id_administracion, agregadopor, fechaagregado, status)
             VALUES(NEW.nombre_completo, NEW.email, NEW.rfc, NEW.telefono, NEW.celular, NEW.password, NEW.tipo, (SELECT MAX(id_administracion) FROM cat_administraciones WHERE status=1),  NEW.agregadopor, NEW.fechaagregado, NEW.status)
        RETURNING id_usuario INTO NEW.id_usuario;
        RETURN NEW;
      ELSIF TG_OP = 'UPDATE' THEN
       UPDATE usuarios SET nombre_completo=NEW.nombre_completo, email=NEW.email, telefono=NEW.telefono, celular=NEW.celular, password=NEW.password, tipo=NEW.tipo, rfc=NEW.rfc, id_administracion=(SELECT MAX(id_administracion) FROM cat_administraciones WHERE status=1), status=NEW.status WHERE id_usuario=OLD.id_usuario;
       RETURN NEW;
      ELSIF TG_OP = 'DELETE' THEN
       UPDATE usuarios SET status=0 WHERE id_usuario=OLD.id_usuario;
       RETURN NULL;
      END IF;
      RETURN NEW;
    END;
$$;
 ,   DROP FUNCTION public.cat_usuarios_vw_dml();
       public          postgres    false            ?            1255    32813 !   f_concepto_recaudacion_completo()    FUNCTION     -  CREATE FUNCTION public.f_concepto_recaudacion_completo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    BEGIN
        IF (TG_OP = 'UPDATE') THEN
            NEW.concepto_recaudacion_completo = concat(f_get_clave_contribucion(NEW.id_cve_contrib), '.',NEW.concepto_recaudacion);
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            NEW.concepto_recaudacion_completo = concat(f_get_clave_contribucion(NEW.id_cve_contrib), '.',NEW.concepto_recaudacion);
            RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$$;
 8   DROP FUNCTION public.f_concepto_recaudacion_completo();
       public          postgres    false            ?            1255    32814    f_get_clase_ingreso(integer)    FUNCTION     ?  CREATE FUNCTION public.f_get_clase_ingreso(pid_clase_ingreso integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
 vCLASE_INGRESO TEXT;

BEGIN
  SELECT CONCAT(ci.cve_ingreso,'.',cic.clase_ingreso)
    INTO vCLASE_INGRESO
    FROM cat_ingresos_clase cic, cat_ingresos ci
   WHERE cic.id_ingreso = ci.id_ingreso
     AND cic.id_clase_ingreso = pid_clase_ingreso;

  RETURN vCLASE_INGRESO;
END;
$$;
 E   DROP FUNCTION public.f_get_clase_ingreso(pid_clase_ingreso integer);
       public          postgres    false            ?            1255    32815 !   f_get_clave_contribucion(integer)    FUNCTION     '  CREATE FUNCTION public.f_get_clave_contribucion(pid_cve_contribucion integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
 vCLAVE_CONTRIBUCION TEXT;

BEGIN
  SELECT CONCAT(ci.cve_ingreso,'.',cic.clase_ingreso,'.',cicc.cve_contribucion)
    INTO vCLAVE_CONTRIBUCION
    FROM cat_ingresos_cves_contribucion cicc, cat_ingresos_clase cic, cat_ingresos ci
   WHERE cic.id_ingreso = ci.id_ingreso
     AND cicc.id_clase_ingreso = cic.id_clase_ingreso
     AND cicc.id_cve_contribucion = pid_cve_contribucion;

  RETURN vCLAVE_CONTRIBUCION;
END;
$$;
 M   DROP FUNCTION public.f_get_clave_contribucion(pid_cve_contribucion integer);
       public          postgres    false            ?            1255    32816 #   f_get_concepto_recaudacion(integer)    FUNCTION     ?  CREATE FUNCTION public.f_get_concepto_recaudacion(pid_concepto_recaudacion integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
 vCONCEPTO_RECAUDACION TEXT;

BEGIN
  SELECT CONCAT(ci.cve_ingreso,'.',cic.clase_ingreso,'.',cicc.cve_contribucion,'.',cicr.concepto_recaudacion)
    INTO vCONCEPTO_RECAUDACION
    FROM cat_ingresos_concepto_recaudacion cicr, cat_ingresos_cves_contribucion cicc, cat_ingresos_clase cic, cat_ingresos ci
   WHERE cic.id_ingreso = ci.id_ingreso
     AND cicc.id_clase_ingreso = cic.id_clase_ingreso
     AND cicr.id_cve_contrib = cicc.id_cve_contribucion
     AND cicr.id_concepto_recaudacion = pid_concepto_recaudacion;

  RETURN vCONCEPTO_RECAUDACION;
END;
$$;
 S   DROP FUNCTION public.f_get_concepto_recaudacion(pid_concepto_recaudacion integer);
       public          postgres    false                        1255    32817    f_get_cve_cat(integer)    FUNCTION       CREATE FUNCTION public.f_get_cve_cat(pid_catastral_base integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
 vCVE_CAT TEXT;

BEGIN
  SELECT cve_cat
    INTO vCVE_CAT
    FROM catastral_base
   WHERE id_catastral_base = pid_catastral_base;

  RETURN vCVE_CAT;
END;
$$;
 @   DROP FUNCTION public.f_get_cve_cat(pid_catastral_base integer);
       public          postgres    false                       1255    32818 +   f_get_descripcion_cuenta(character varying)    FUNCTION     8  CREATE FUNCTION public.f_get_descripcion_cuenta(pcta_contable character varying) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
 vDESCRIPCION TEXT;

BEGIN
  SELECT descripcion
    INTO vDESCRIPCION
    FROM cat_ctas_contables_saacg
   WHERE cuenta_contable = pCta_Contable;

  RETURN vDESCRIPCION;
END;
$$;
 P   DROP FUNCTION public.f_get_descripcion_cuenta(pcta_contable character varying);
       public          postgres    false                       1255    32819 $   f_get_domicilio_cat_predios(integer)    FUNCTION     ?  CREATE FUNCTION public.f_get_domicilio_cat_predios(pid_predio integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
 vDOMICILIO TEXT;

BEGIN
 SELECT CONCAT_WS('', calle, coalesce(' #'||no_exterior, ' S/N') , coalesce('-'||letra, ''), coalesce(' int. '||no_interior, ''), coalesce(', Col. '||colonia, ''))
    INTO vDOMICILIO
    FROM cat_predios
   WHERE id_predio = pID_PREDIO;

  RETURN vDOMICILIO;
END;
$$;
 F   DROP FUNCTION public.f_get_domicilio_cat_predios(pid_predio integer);
       public          postgres    false                       1255    32820 '   f_get_domicilio_catastral_base(integer)    FUNCTION     ?  CREATE FUNCTION public.f_get_domicilio_catastral_base(pid_catastral_base integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
 vDOMICILIO TEXT;

BEGIN
 SELECT CONCAT_WS('', calle_pred, coalesce(' #'||num_ext_pred, ' S/N'), coalesce(' int. '||num_int_pred, ''), coalesce(', Col. '||col_pred, ''))
    INTO vDOMICILIO
    FROM catastral_base
   WHERE id_catastral_base = pID_CATASTRAL_BASE;

  RETURN vDOMICILIO;
END;
$$;
 Q   DROP FUNCTION public.f_get_domicilio_catastral_base(pid_catastral_base integer);
       public          postgres    false                       1255    32821 &   f_get_domicilio_contribuyente(integer)    FUNCTION     ?  CREATE FUNCTION public.f_get_domicilio_contribuyente(pid_contribuyente integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
 vDOMICILIO TEXT;

BEGIN
 SELECT CONCAT_WS('', dom_calle, coalesce(' #'||dom_no_exterior, ' S/N') , coalesce('-'||dom_letra, ''), coalesce(' int. '||dom_no_interior, ''), coalesce(', Col. '||dom_colonia, ''))
    INTO vDOMICILIO
    FROM cat_contribuyentes
   WHERE id_contribuyente = pID_CONTRIBUYENTE;

  RETURN vDOMICILIO;
END;
$$;
 O   DROP FUNCTION public.f_get_domicilio_contribuyente(pid_contribuyente integer);
       public          postgres    false                       1255    32822 !   f_get_domicilio_licencia(integer)    FUNCTION     ?  CREATE FUNCTION public.f_get_domicilio_licencia(pid_licencia integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
 vDOMICILIO TEXT;

BEGIN
    SELECT CONCAT_WS('', calle, coalesce(' #'||no_exterior, ' S/N') , coalesce('-'||letra, ''), coalesce(' int. '||no_interior, ''), coalesce(', Col. '||colonia, ''))
INTO vDOMICILIO
FROM licencias
  WHERE id_licencia = pID_LICENCIA;
  RETURN vDOMICILIO;
END;
$$;
 E   DROP FUNCTION public.f_get_domicilio_licencia(pid_licencia integer);
       public          postgres    false                       1255    32823 (   f_get_domicilio_motor_inmuebles(integer)    FUNCTION     ?  CREATE FUNCTION public.f_get_domicilio_motor_inmuebles(pid_inmueble_motor integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
 vDOMICILIO TEXT;

BEGIN
 SELECT CONCAT_WS('', calle, coalesce(' #'||no_exterior, ' S/N') , coalesce('-'||letra, ''), coalesce(' int. '||no_interior, ''), coalesce(', Col. '||colonia, ''))
    INTO vDOMICILIO
    FROM motor_inmuebles
   WHERE id_inmueble_motor = pID_INMUEBLE_MOTOR;

  RETURN vDOMICILIO;
END;
$$;
 R   DROP FUNCTION public.f_get_domicilio_motor_inmuebles(pid_inmueble_motor integer);
       public          postgres    false                       1255    32824 &   f_get_fecha_vencimiento(date, integer)    FUNCTION     ?  CREATE FUNCTION public.f_get_fecha_vencimiento(p_fecha date, p_numdias integer) RETURNS date
    LANGUAGE plpgsql
    AS $$
declare
	Ldfecha   DATE  := p_fecha;
	Lndias    int   := p_numdias;
	Lncuenta  int   := 0;
	Lvdia     text;
	Ldtemp    INT;
	flag 	  int;
BEGIN

	WHILE Lncuenta < Lndias LOOP
      Ldfecha := Ldfecha + interval '1' day;
      SELECT SUBSTR(UPPER(TO_CHAR(Ldfecha, 'day')),1,1) INTO Lvdia;
      IF Lvdia != 'S' THEN

					SELECT 1
					INTO Ldtemp
					FROM cat_dias_feriados
					WHERE fecha = Ldfecha
					AND status = 1;

					IF Ldtemp IS NULL THEN
							Lncuenta := Lncuenta + 1;
					END IF;

      END IF;
   END LOOP;

   RETURN Ldfecha;

END;
$$;
 O   DROP FUNCTION public.f_get_fecha_vencimiento(p_fecha date, p_numdias integer);
       public          postgres    false            ?            1255    32825 $   f_get_ing_monto_estadistica(integer)    FUNCTION     ?  CREATE FUNCTION public.f_get_ing_monto_estadistica(pid_control_caja integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
 vMONTO_ESTADISTICA NUMERIC;

BEGIN
  SELECT SUM(ROUND((SELECT SUM(IMPORTE) FROM liquidaciones_det WHERE id_liquidacion=ing_cobros.id_liquidacion),2))
    INTO vMONTO_ESTADISTICA
    FROM ing_cobros
   WHERE status=1
     and recibo_estatus='A'
     and id_control_caja= pid_control_caja;

  RETURN vMONTO_ESTADISTICA;
END;
$$;
 L   DROP FUNCTION public.f_get_ing_monto_estadistica(pid_control_caja integer);
       public          postgres    false            ?            1255    32826 (   f_get_ingreso_tipo_fuente(text, integer)    FUNCTION     &  CREATE FUNCTION public.f_get_ingreso_tipo_fuente(pcve_fuente_ingreso text, panio integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
 vTIPO_INGRESO TEXT;
BEGIN
    SELECT cit.descripcion
    INTO vTIPO_INGRESO
    FROM cat_ingresos_tipo cit, cat_ingresos_cves_contribucion cicc, cat_ingresos_fuente cif
    WHERE cit.id_tipo_ingreso=cicc.id_tipo_ingreso
      AND cicc.id_cve_contribucion=cif.id_cve_contrib
      AND cif.anio=panio
      AND f_get_fuente_ingreso(cif.id_fuente_ingreso)=pcve_fuente_ingreso;
  RETURN vTIPO_INGRESO;
END;
$$;
 Y   DROP FUNCTION public.f_get_ingreso_tipo_fuente(pcve_fuente_ingreso text, panio integer);
       public          postgres    false            ?            1255    32827    f_get_monto_liq_round(integer)    FUNCTION     ?  CREATE FUNCTION public.f_get_monto_liq_round(pid_liquidacion integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
 total NUMERIC;

BEGIN
  SELECT sum(round(importe,2)) INTO total FROM (
                  SELECT id_concepto_recaudacion, sum(importe)importe FROM liquidaciones_det
                  WHERE id_liquidacion = pid_liquidacion
                  GROUP BY id_concepto_recaudacion) a;

  RETURN total;
END;
$$;
 E   DROP FUNCTION public.f_get_monto_liq_round(pid_liquidacion integer);
       public          postgres    false                       1255    32828 )   f_get_predial(character varying, integer)    FUNCTION     ?M  CREATE FUNCTION public.f_get_predial(pcve_catastral character varying DEFAULT 'N/A'::character varying, "pPeriodo" integer DEFAULT 0) RETURNS TABLE(anio_base integer, periodo_base integer, periodo_base_completo integer, anio_topado integer, cve_catastral character varying, ult_periodo_pago character varying, anio_ult_pago text, bimestre_ult_pago integer, flag_requiere_aclaracion integer, flag_tercera_edad integer, status integer, flag_sin_beneficios integer, uso_predio character varying, flag_acuerdo_cabildo integer, obervacion_especial text, flag_procede integer, flag_pago_minimo integer, flag_pae integer, flag_embargo integer, flag_desc_pens_activo integer, periodo_ini_completo integer, periodo_fin_completo integer, anio_ini text, periodo_ini integer, anio_fin text, periodo_fin integer, flag_anio_completo integer, flag_calculo_tercera_edad integer, id_catastral_base integer, rfc text, fecha_proceso timestamp without time zone, cve_cat text, propietario text, id_municipio integer, id_estado integer, col_pred text, calle_pred text, num_ext_pred text, num_int_pred text, col_prop text, calle_prop text, num_ext_prop text, num_int_prop text, tel text, cve_anterior text, valor_ter_ant text, valor_cons_ant text, valor_ter text, valor_cons text, valor_catastral_actual_aux text, at text, ac_actual_aux text, fecha_alta date, id_tipo_predio_actual_aux integer, tipo_pred text, cve_traslanet_aux character varying, domicilio text, fecha_val_act timestamp without time zone, clave_gob_edo text, estado_prop character varying, municipio_prop text, base_gravable_aux text, flag_predio_topado_actual_aux integer, pago_anterior_actual_aux numeric, predio_unidad_medida text, base_gravable text, cve_traslanet character varying, fecha_calculo date, fechaini timestamp without time zone, fecha_limite date, fecha_ini_bim timestamp without time zone, fecha_fin_bim timestamp without time zone, fechafin timestamp without time zone, fecha_venc text, bimestre_vencido integer, valor_uma numeric, montos_bimestrales_pens numeric, valor_catastral_pasado_aux text, ac_pasado_aux text, id_tipo_predio_pasado_aux integer, flag_predio_topado_pasado_aux integer, impuesto_topado_pasado_aux numeric, id_campana_descuento_det integer, concepto_recaudacion character varying, descuento_monto numeric, descuento_porc numeric, cve_traslanet_importe character varying, concepto text, id_concepto_recaudacion integer, calc_base_gravable text, calc_area_constr text, flag_predio_topado integer, pago_anterior numeric, calc_id_tipo_predio integer, calc_tipo_valor integer, base_calculo_predial character varying, resultactualizacion integer, campana_descuento_calculo text, id_limite integer, tipo_tarifa integer, limite_inferior numeric, limite_inferor_sm numeric, limite_superior numeric, limite_superior_sm numeric, cuota numeric, cuota_vsmgz numeric, porcentaje_edificado numeric, porcentaje_baldio numeric, porcentaje_ieopm numeric, excenta numeric, excentaf numeric, limite_intsoc_sm numeric, limite_intsoc_monto numeric, limite_intpop_sm numeric, limite_intpop_monto numeric, deducc_intsoc_sm numeric, deducc_intsoc_monto numeric, porcentajes_calculo numeric)
    LANGUAGE plpgsql
    AS $_$
#variable_conflict use_column
	DECLARE v_fecha_calculo DATE DEFAULT NOW()::DATE;
	DECLARE v_fechaini TIMESTAMP DEFAULT (NOW()::DATE)::TIMESTAMP;
	DECLARE v_base_calculo_predial VARCHAR DEFAULT (SELECT LOWER(valor) FROM variables WHERE etiqueta = 'PREDIAL_APLICAR_REDUCC_CALCULO_ACCESORIOS' AND status = 1); /*1.1*/
	DECLARE v_flag_pae INT DEFAULT (SELECT COALESCE((SELECT status FROM predial_config_calculo WHERE  NOW() BETWEEN vigencia_ini AND vigencia_fin AND clave_proceso = 'PRED_GEJE' AND status = 1), 0)::INT); /*1.2*/
	DECLARE v_flag_embargo INT DEFAULT (SELECT COALESCE((SELECT status FROM predial_config_calculo WHERE  NOW() BETWEEN vigencia_ini AND vigencia_fin AND clave_proceso = 'PRED_GEMB' AND status = 1), 0)::INT); /*1.3*/
	DECLARE v_resultActualizacion INT DEFAULT (SELECT COALESCE((SELECT status FROM predial_config_calculo WHERE  NOW() BETWEEN vigencia_ini AND vigencia_fin AND clave_proceso = 'PRED_ACT' AND status = 1), 0)::INT); /*1.4*/
	DECLARE v_flag_desc_pens_activo INT DEFAULT (SELECT COALESCE((SELECT status FROM predial_config_calculo WHERE  NOW() BETWEEN vigencia_ini AND vigencia_fin AND clave_proceso = 'PRED_DESC_PENS' AND status = 1), 0)::INT); /*1.5*/
BEGIN

	--Eliminamos tabla temporal temp_cat_predios
	DROP TABLE IF EXISTS temp_cat_predios;
	DROP TABLE IF EXISTS temp_datos_predio;
	DROP TABLE IF EXISTS temp_anios_topados;
	DROP TABLE IF EXISTS temp_datos_base_cat;
	DROP TABLE IF EXISTS temp_distinct_cve_traslanet;
	--DROP TABLE IF EXISTS temp_conceptos_recaudacion;
	DROP TABLE IF EXISTS temp_camp_descuentos;
	DROP TABLE IF EXISTS temp_periodos;
	DROP TABLE IF EXISTS temp_periodos_cve_catastral;	
	DROP TABLE IF EXISTS temp_calculaMontoBimestral_1;

IF $1 = 'N/A' THEN
CREATE TEMP TABLE temp_cat_predios AS
SELECT p.cve_catastral 
FROM cat_predios p 
WHERE predial_ult_periodo_pago::INT < $2 
			--AND status = 1 
			AND flag_requiere_aclaracion = 0;						
ELSE		
CREATE TEMP TABLE temp_cat_predios AS
SELECT p.cve_catastral 
FROM cat_predios p 
WHERE predial_ult_periodo_pago::INT < $2 
			--AND status = 1 
			AND flag_requiere_aclaracion = 0
			AND cve_catastral = $1;
			
END IF;
													--'010100101003220';
													--'010506586238728';
													--'010100101001003';
													--'010106401052006';		
											

CREATE TEMP TABLE temp_anios_topados AS
SELECT token AS anio_topado from variables v, unnest(string_to_array(v.valor, ',')) s(token)  WHERE etiqueta = 'ANIOS_TOPADOS';

			
CREATE TEMP TABLE temp_datos_predio AS
SELECT *, 
			 CASE WHEN	bimestre_ult_pago = 6 AND flag_desc_pens_activo = 1 AND flag_tercera_edad = 1 AND anio_ult_pago::int = (date_part('year', now())-1) AND flag_anio_completo = 1 
					  THEN 1 
						ELSE 0 
						END flag_calculo_tercera_edad
FROM	(SELECT *, 
						 CASE WHEN anio_ini < anio_fin AND periodo_fin = 6 
								  THEN 1 
								  WHEN anio_ini = anio_fin AND periodo_ini = 1 AND periodo_fin = 6 
								  THEN 1 
								  ELSE 0 
								  END flag_anio_completo			 
			FROM	(SELECT *,
									 SUBSTRING(periodo_ini_completo::VARCHAR,1,4) anio_ini,
									 SUBSTRING(periodo_ini_completo::VARCHAR,5,2)::INT * 1 periodo_ini, 
									 SUBSTRING(periodo_fin_completo::VARCHAR,1,4) anio_fin, 
									 SUBSTRING(periodo_fin_completo::VARCHAR,5,2)::INT * 1 periodo_fin  
				    FROM	(SELECT *, 
												  CASE WHEN bimestre_ult_pago = 6 
												  THEN ((anio_ult_pago::INT + 1) ||'01')::INT
												  ELSE (anio_ult_pago ||'0'|| (bimestre_ult_pago + 1))::INT
												  END periodo_ini_completo,
												  $2 periodo_fin_completo
									FROM (SELECT cve_catastral,
															 predial_ult_periodo_pago ult_periodo_pago, 
															 SUBSTRING(predial_ult_periodo_pago,1,4) anio_ult_pago,
															 SUBSTRING(predial_ult_periodo_pago,5,2)::INT * 1 bimestre_ult_pago,
															 flag_requiere_aclaracion,
															 flag_tercera_edad,
															 status,
															 (SELECT flag_sin_beneficios from cat_contribuyentes where id_contribuyente=(SELECT id_contribuyente from cat_predios_propietarios where id_predio=cp.id_predio)) flag_sin_beneficios,
															 (SELECT uso_predio from catastral_base where cve_cat = cp.cve_catastral) uso_predio,															 
															 cp.flag_acuerdo_cabildo,
															 cp.obervacion_especial,
															 cp.flag_procede, 
															 cp.flag_pago_minimo,
															 (flag_pae::INT * /*1.2*/ v_flag_pae) as flag_pae,
															 (flag_embargo::INT * /*1.3*/ v_flag_embargo) as flag_embargo,										
															 /*1.5*/ v_flag_desc_pens_activo AS flag_desc_pens_activo
											 FROM cat_predios cp
											 WHERE cve_catastral IN (SELECT p.cve_catastral FROM temp_cat_predios p) 
											 AND (predial_ult_periodo_pago <> '' OR predial_ult_periodo_pago IS NOT NULL)
											 ) T0
								  --WHERE (T0.uso_predio NOT IN ('PRGO') OR T0.uso_predio IS NULL)
									) T1
						WHERE periodo_fin_completo > periodo_ini_completo
						) T2
			) T3;
			



CREATE TEMP TABLE temp_datos_base_cat AS
SELECT * , 
			 CASE WHEN flag_predio_topado_actual_aux = 1 AND (SELECT count(anio_topado) from temp_anios_topados WHERE anio_topado::int = date_part('year', now())) >= 1 
			 THEN (SELECT COALESCE(impuesto_topado,0) FROM predial_topes_anuales WHERE cve_catastral = cve_cat AND DATE(NOW()) <= date(fecha) ORDER BY fecha DESC LIMIT 1) 
			 ELSE 0 						
			 END pago_anterior_actual_aux,
			 CASE WHEN clave_gob_edo = 'R' 
			 THEN 'Has.' 
			 ELSE 'm<sup>2</sup>' 
			 END predio_unidad_medida,
			 CASE WHEN flag_predio_topado_actual_aux = 1
			 THEN CASE WHEN base_gravable_aux IS NULL OR base_gravable_aux = ''
						THEN valor_catastral_actual_aux
						ELSE base_gravable_aux
						END
			  ELSE valor_catastral_actual_aux
				END AS base_gravable,				
				CASE WHEN cve_traslanet_aux = 'IPU'
				THEN cve_traslanet_aux || CASE WHEN COALESCE(ac_actual_aux::DECIMAL,0) > 0 
																	THEN 'E' 
																	ELSE 'B' 
																	END
				ELSE cve_traslanet_aux
				END cve_traslanet
FROM	(SELECT id_catastral_base, rfc, fecha_proceso, cve_cat, 
							CASE WHEN propietario IS NULL OR propietario = '' 
							THEN 'Sin datos' 
							ELSE propietario 
							END AS propietario,
							id_municipio, 
							(SELECT id_estado from cat_municipios where id_municipio=cb.id_municipio) id_estado,
							col_pred, calle_pred, num_ext_pred, num_int_pred, col_prop, calle_prop, num_ext_prop, num_int_prop, tel, cve_anterior, 
							COALESCE(NULLIF(valor_ter_ant,'') ,'0') AS valor_ter_ant, 
							COALESCE(NULLIF(valor_cons_ant,'') ,'0') AS valor_cons_ant, 
							COALESCE(NULLIF(valor_ter,'') ,'0') AS valor_ter, 
							COALESCE(NULLIF(valor_cons,'') ,'0') AS valor_cons, 
							COALESCE(NULLIF(valor_catastral,'') ,'0') AS valor_catastral_actual_aux, 
							COALESCE(NULLIF(at,'') ,'0') AS at,  
							COALESCE(NULLIF(ac,'') ,'0') AS ac_actual_aux, 
							fecha_alta,
							(SELECT id_tipo_predio FROM cat_tipo_predio WHERE clave_gob_edo = trim(concat(trim(cb.tipo_pred),' ',trim(cb.uso_predio))))  id_tipo_predio_actual_aux,
							(SELECT tipo_predio FROM cat_tipo_predio WHERE clave_gob_edo = trim(concat(trim(cb.tipo_pred),' ',trim(cb.uso_predio)))) tipo_pred,
							(SELECT cve_traslanet FROM cat_tipo_predio WHERE clave_gob_edo = trim(concat(trim(cb.tipo_pred),' ',trim(cb.uso_predio)))) cve_traslanet_aux,
							f_get_domicilio_catastral_base(id_catastral_base) domicilio, fechaagregado::TIMESTAMP fecha_val_act,
							trim(concat(trim(cb.tipo_pred),' ',trim(cb.uso_predio))) clave_gob_edo,
							(SELECT abreviatura from cat_estados where id_estado =estado_prop) estado_prop,
							(SELECT nombre from cat_municipios where id_municipio = municipio_prop) municipio_prop,
							(SELECT valor_catastral from catastral_kardex_det where cve_cat=cb.cve_cat and (date_part('year', now())::VARCHAR || '-12-31')::DATE BETWEEN date(fechaagregado) AND date(fecha_insert_registro) ORDER BY to_number(valor_catastral, 'L9G999g9999.9999') DESC LIMIT 1) base_gravable_aux,
							(SELECT flag_predio_topado FROM predial_topes_anuales WHERE cve_catastral=cb.cve_cat and DATE(NOW()) <= date(fecha) ORDER BY fecha DESC LIMIT 1) flag_predio_topado_actual_aux				
			FROM catastral_base cb
			WHERE cve_cat IN (SELECT p.cve_catastral FROM temp_datos_predio p)
			)T0;






CREATE TEMP TABLE temp_distinct_cve_traslanet AS
SELECT cve 
FROM (SELECT string_agg(cve_traslanet, ',') || ',ACT' || ',IEOPM' || ',RECP' || ',MUL' || ',DPENS' || ',GEJE' || ',GEMB' || ',REDPRED' || ',DPREDENE' || ',DPREDFEB' as val 
			FROM (SELECT DISTINCT cve_traslanet 
						FROM temp_datos_base_cat
					 )TAUX
		 )TAUX2, unnest(string_to_array(TAUX2.val, ','))	s(cve);



/*CREATE TEMP TABLE temp_conceptos_recaudacion AS
SELECT cve_traslanet, id_concepto_recaudacion, descripcion, f_get_concepto_recaudacion(id_concepto_recaudacion) cve_concepto_recaudacion
FROM cat_ingresos_concepto_recaudacion
WHERE anio = date_part('year', now())
AND status = 1
AND cve_traslanet IN (SELECT cve FROM temp_distinct_cve_traslanet);*/



CREATE TEMP TABLE temp_camp_descuentos AS
SELECT id_campana_descuento_det, concepto_recaudacion, descuento_monto, descuento_porc, cve_traslanet_importe,
			 (SELECT descripcion FROM cat_ingresos_concepto_recaudacion WHERE f_get_concepto_recaudacion(id_concepto_recaudacion)=cdd.concepto_recaudacion AND anio = to_char(NOW(), 'YYYY')::INT) concepto,
			 (SELECT id_concepto_recaudacion FROM cat_ingresos_concepto_recaudacion WHERE f_get_concepto_recaudacion(id_concepto_recaudacion) = cdd.concepto_recaudacion AND anio = to_char(NOW(), 'YYYY')::INT) id_concepto_recaudacion
FROM cat_campanas_descuento_det cdd
WHERE id_campana_descuento_det IN (SELECT MAX(id_campana_descuento_det)
																	 FROM cat_campanas_descuento_det cdd
																	 WHERE cve_traslanet_importe IN (SELECT cve FROM temp_distinct_cve_traslanet)
																	 AND NOW()::DATE BETWEEN vigencia_ini AND vigencia_fin AND status = 1
																	 GROUP BY cve_traslanet_importe); 


CREATE TEMP TABLE temp_periodos as
SELECT anio_base, 
			 periodo_base,
			 (anio_base::VARCHAR || '0' ||periodo_base::VARCHAR)::INT AS periodo_base_completo,
			 CASE WHEN anio_topado IS NULL
			 THEN 0
			 ELSE 1
			 END anio_topado
FROM	(SELECT * 
			 FROM generate_series((SELECT MIN(anio_ini) FROM temp_datos_predio)::INT,(SELECT MAX(anio_fin) FROM temp_datos_predio)::INT) AS anio_base, generate_series(1,6) periodo_base) T0	
			LEFT JOIN
			temp_anios_topados T1
			ON T1.anio_topado::INT = anio_base;


																												
CREATE TEMP TABLE temp_periodos_cve_catastral as
SELECT T1.*,
			 to_char(fechafin, 'YYYY/MM/DD') AS fecha_venc, 
			 CASE WHEN fechaini > fechafin 
			 THEN 1 
			 ELSE 0 
			 END bimestre_vencido,
			 sm.sm AS valor_uma,
			 CASE WHEN flag_calculo_tercera_edad = 1 
			 THEN  sm.sm / 6 
			 ELSE 0 
			 END montos_bimestrales_pens						 
FROM (SELECT *,
						 fecha_limite::TIMESTAMP AS fecha_fin_bim, 
						 (fecha_limite::DATE + INTERVAL '15 day')::TIMESTAMP AS fechafin
			FROM (SELECT *,
									 v_fecha_calculo AS fecha_calculo, 
									 v_fechaini as fechaini, 
									 (date_trunc('MONTH', (tmpP.anio_base::VARCHAR || '-' || (tmpP.periodo_base * 2)::VARCHAR || '-01')::DATE) + INTERVAL '1 MONTH - 1 day')::DATE AS fecha_limite,			 
									 (tmpP.anio_base::VARCHAR || '-' ||((tmpP.periodo_base * 2) - 1)::VARCHAR || '-01')::TIMESTAMP AS fecha_ini_bim		
						FROM	temp_periodos tmpP
						INNER JOIN
						(SELECT * 
							FROM temp_datos_predio tmpDP
							INNER JOIN
							temp_datos_base_cat tmpDBC ON tmpDBC.cve_cat = tmpDP.cve_catastral) tmpDP_DBC
						ON tmpP.periodo_base_completo >= tmpDP_DBC.periodo_ini_completo AND tmpP.periodo_base_completo <= tmpDP_DBC.periodo_fin_completo
						)T0
			)T1
			LEFT JOIN sm ON T1.fecha_fin_bim::DATE BETWEEN sm.fecha::DATE AND sm.fecha_f::DATE AND sm.status = 1;							



RETURN query (SELECT *,
										 CASE WHEN COALESCE(calc_area_constr::DECIMAL,0) > 0 
										 THEN porcentaje_edificado 
										 ELSE porcentaje_baldio 
										 END porcentajes_calculo
							FROM
									(SELECT *,
													CASE WHEN fecha_fin_bim::DATE < fecha_val_act::DATE THEN COALESCE(NULLIF(valor_catastral_pasado_aux,'') ,valor_catastral_actual_aux) ELSE valor_catastral_actual_aux END AS calc_base_gravable,
													CASE WHEN fecha_fin_bim::DATE < fecha_val_act::DATE THEN COALESCE(NULLIF(ac_pasado_aux,'') ,ac_actual_aux) ELSE ac_actual_aux END AS calc_area_constr,
													CASE WHEN fecha_fin_bim::DATE < fecha_val_act::DATE THEN COALESCE(flag_predio_topado_pasado_aux, flag_predio_topado_actual_aux) ELSE flag_predio_topado_actual_aux END AS flag_predio_topado,
													CASE WHEN fecha_fin_bim::DATE < fecha_val_act::DATE THEN COALESCE(impuesto_topado_pasado_aux, pago_anterior_actual_aux) ELSE pago_anterior_actual_aux END AS pago_anterior,
													CASE WHEN fecha_fin_bim::DATE < fecha_val_act::DATE THEN COALESCE(id_tipo_predio_pasado_aux::INT, id_tipo_predio_actual_aux::INT) ELSE id_tipo_predio_actual_aux::INT END AS calc_id_tipo_predio,
													CASE WHEN fecha_fin_bim::DATE < fecha_val_act::DATE THEN 2 ELSE 1 END AS calc_tipo_valor,
													v_base_calculo_predial /*1.1*/ AS base_calculo_predial,					 
													v_resultActualizacion /*1.4*/  AS resultActualizacion,
													CASE WHEN tmpCD.descuento_monto IS NOT NULL AND tmpCD.descuento_porc IS NOT NULL 
													THEN CASE WHEN tmpCD.descuento_monto > 0 THEN 'MONTO'
																		WHEN tmpCD.descuento_porc > 0 THEN 'PORC'
																		ELSE 'N/A'
															 END
													ELSE 'N/A'
													END	campana_descuento_calculo
									FROM
											(SELECT * 
											FROM 
													temp_periodos_cve_catastral tmpPCC
													LEFT JOIN LATERAL
													(SELECT valor_catastral AS valor_catastral_pasado_aux,
																	ac AS ac_pasado_aux, 
																	(SELECT id_tipo_predio FROM cat_tipo_predio WHERE clave_gob_edo = trim(concat(trim(cb.tipo_pred),' ',trim(cb.uso_predio))))  id_tipo_predio_pasado_aux,
																	(SELECT flag_predio_topado FROM predial_topes_anuales WHERE cve_catastral = cb.cve_cat AND tmpPCC.fecha_fin_bim::DATE <= date(fecha) ORDER BY fecha LIMIT 1) flag_predio_topado_pasado_aux, 
																	(SELECT impuesto_topado FROM predial_topes_anuales WHERE cve_catastral = cb.cve_cat AND tmpPCC.fecha_fin_bim::DATE <= date(fecha) ORDER BY fecha LIMIT 1) impuesto_topado_pasado_aux 									
													 FROM catastral_kardex_det cb
													 WHERE cb.cve_cat = tmpPCC.cve_catastral
													 AND tmpPCC.fecha_fin_bim::DATE BETWEEN cb.fechaagregado::DATE AND cb.fecha_insert_registro::DATE 
													 ORDER BY cb.fecha_insert_registro DESC
													 LIMIT 1) sqValorCatastral ON TRUE
											 ) sq_tmpPCC_sqValorCatastral
											 LEFT JOIN temp_camp_descuentos tmpCD ON tmpCD.cve_traslanet_importe = sq_tmpPCC_sqValorCatastral.cve_traslanet 																					
																															 AND sq_tmpPCC_sqValorCatastral.flag_anio_completo = 1
																															 AND TRIM(sq_tmpPCC_sqValorCatastral.clave_gob_edo) <> 'F'
																															 AND sq_tmpPCC_sqValorCatastral.anio_base = date_part('year', now())) sq_tmpPCC_sqValorCatastral_tmpCD																								 
								LEFT JOIN LATERAL
								(SELECT id_limite, tipo_tarifa, limite_inferior, limite_inferor_sm, limite_superior, limite_superior_sm, cuota, cuota_vsmgz, 
												porcentaje_edificado, porcentaje_baldio, porcentaje_ieopm, excenta, excentaf, limite_intsoc_sm, limite_intsoc_monto,
												limite_intpop_sm, limite_intpop_monto, deducc_intsoc_sm, deducc_intsoc_monto
								 FROM predial_limites
								 WHERE sq_tmpPCC_sqValorCatastral_tmpCD.calc_base_gravable::NUMERIC BETWEEN limite_inferior AND limite_superior
											 AND id_estado = sq_tmpPCC_sqValorCatastral_tmpCD.id_estado
											 AND (id_municipio = sq_tmpPCC_sqValorCatastral_tmpCD.id_municipio or id_municipio is null)
											 AND id_tipo_predio = sq_tmpPCC_sqValorCatastral_tmpCD.calc_id_tipo_predio
											 AND sq_tmpPCC_sqValorCatastral_tmpCD.fecha_fin_bim::DATE BETWEEN fecha_ini::DATE AND fecha_fin::DATE
											 AND status = 1
								) tmpPL ON TRUE
								ORDER BY cve_catastral,anio_base,periodo_base);


																										 
END
$_$;
 Z   DROP FUNCTION public.f_get_predial(pcve_catastral character varying, "pPeriodo" integer);
       public          postgres    false            	           1255    32830 $   f_get_predio_by_liquidacion(integer)    FUNCTION     ?  CREATE FUNCTION public.f_get_predio_by_liquidacion(liquidacionid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE predid INT;
BEGIN
        SELECT id_predio INTO predid FROM cat_predios WHERE cve_catastral = (SELECT cve_cat FROM catastral_base WHERE id_catastral_base = (SELECT id_catastral_base FROM liquidaciones WHERE id_liquidacion = liquidacionid));

        RETURN predid;
END;
$$;
 I   DROP FUNCTION public.f_get_predio_by_liquidacion(liquidacionid integer);
       public          postgres    false            
           1255    32831     f_get_total_liquidacion(integer)    FUNCTION     (  CREATE FUNCTION public.f_get_total_liquidacion(liquidacionid integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE total NUMERIC;
BEGIN
        SELECT  SUM(ROUND(importe,2)) INTO total
        FROM liquidaciones_det WHERE id_liquidacion = liquidacionid;

        RETURN total;
END;
$$;
 E   DROP FUNCTION public.f_get_total_liquidacion(liquidacionid integer);
       public          postgres    false                       1255    32832    f_get_ultimo_dia_mes(date)    FUNCTION     ?   CREATE FUNCTION public.f_get_ultimo_dia_mes(date) RETURNS date
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
  SELECT (date_trunc('MONTH', $1) + INTERVAL '1 MONTH - 1 day')::date;
$_$;
 1   DROP FUNCTION public.f_get_ultimo_dia_mes(date);
       public          postgres    false                       1255    32833 %   f_licencia_get_ultimo_status(integer)    FUNCTION     ?  CREATE FUNCTION public.f_licencia_get_ultimo_status(pid_licencia_tramites integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
 vid_status ALIAS FOR $1;

BEGIN
 SELECT DISTINCT FIRST_VALUE(id_status)
    OVER (PARTITION BY id_licencias_tramites ORDER BY fechaagregado DESC, id_historial DESC) id_status
    INTO vid_status
    FROM licencias_historial
   WHERE id_licencias_tramites = pid_licencia_tramites
     AND status = 1;

  RETURN vid_status;
END;
$_$;
 R   DROP FUNCTION public.f_licencia_get_ultimo_status(pid_licencia_tramites integer);
       public          postgres    false                       1255    32834 )   f_licencia_get_ultimo_status_txt(integer)    FUNCTION     P  CREATE FUNCTION public.f_licencia_get_ultimo_status_txt(pid_licencias_tramites integer) RETURNS text
    LANGUAGE plpgsql
    AS $_$
DECLARE
 vid_status ALIAS FOR $1;
 vstatus_txt    text;

BEGIN
 SELECT DISTINCT FIRST_VALUE(id_status)
    OVER (PARTITION BY id_licencias_tramites ORDER BY fechaagregado DESC, id_historial DESC) id_status
    INTO vid_status
    FROM licencias_historial
   WHERE id_licencias_tramites = pid_licencias_tramites
     AND status = 1;

 SELECT estatus
   INTO vstatus_txt
   FROM licencias_status
  WHERE id_status = vid_status;

  RETURN vstatus_txt;
END;
$_$;
 W   DROP FUNCTION public.f_licencia_get_ultimo_status_txt(pid_licencias_tramites integer);
       public          postgres    false                       1255    32835 +   f_motor_get_ultimo_status(integer, integer)    FUNCTION     ?  CREATE FUNCTION public.f_motor_get_ultimo_status(pidtipotramite integer, pllavetramite integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
 vid_status integer;

BEGIN
    case pIdTipoTramite
        when 2 then vid_status = f_traslado_get_ultimo_status(pLlaveTramite);
        when 3 then vid_status = f_licencia_get_ultimo_status(pLlaveTramite);
    end case;

  RETURN vid_status;
END;
$$;
 _   DROP FUNCTION public.f_motor_get_ultimo_status(pidtipotramite integer, pllavetramite integer);
       public          postgres    false                       1255    32836 /   f_motor_get_ultimo_status_txt(integer, integer)    FUNCTION     ?  CREATE FUNCTION public.f_motor_get_ultimo_status_txt(pidtipotramite integer, pllavetramite integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    vid_status_txt text;

BEGIN
    case pIdTipoTramite
        when 2 then vid_status_txt = f_traslado_get_ultimo_status_txt(pLlaveTramite);
        when 3 then vid_status_txt = f_licencia_get_ultimo_status_txt(pLlaveTramite);
    end case;

  RETURN vid_status_txt;
END;
$$;
 c   DROP FUNCTION public.f_motor_get_ultimo_status_txt(pidtipotramite integer, pllavetramite integer);
       public          postgres    false                       1255    32837    f_regresa_cadena(text)    FUNCTION     x  CREATE FUNCTION public.f_regresa_cadena(cadena text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    nposfin  INT;
    ncompara TEXT;
    nsize    INT;
    ncad     TEXT;
  BEGIN
    nposfin  = POSITION(' ' IN cadena);
    ncompara = SUBSTR(cadena,1,nposfin );
    nsize    = LENGTH(cadena);
    IF UPPER(ncompara) IN ( UPPER ('jose ')	  		 , UPPER ('J ')				  , UPPER ('J. ')
                , UPPER ('Maria de los ')	 , UPPER ('Ma. de los ')  	  , UPPER ('Ma de los ')
              , UPPER ('Maria del ') 		 , UPPER ('Ma. del')  		  , UPPER ('Ma del ')
              , UPPER ('Maria de ')		 , UPPER ('Ma. de ')		  , UPPER ('Ma de ')
              , UPPER ('Maria ') 			 , UPPER ('Ma. ') 			  , UPPER ('Ma ')
              , UPPER ('Da ')				 , UPPER ('Das ')			  , UPPER ('De ')
              , UPPER ('Del ')			 , UPPER ('Der ')			  , UPPER ('Di ')
              , UPPER ('Die ')			 , UPPER ('DD ')			  , UPPER ('El ')
              , UPPER ('La ')				 , UPPER ('Los ')			  , UPPER ('Las ')
              , UPPER ('Le ')				 , UPPER ('Les ')			  , UPPER ('Mac ')
              , UPPER ('Mc ')				 , UPPER ('Van ')			  , UPPER ('Von ')
              , UPPER ('Y ')				 , UPPER ('de la ')			  , UPPER ('de los ')
              , UPPER ('a la ')
                ) THEN
        ncad =  SUBSTR(cadena,nposfin+1,nsize);
    ELSE
        ncad = cadena;
    END IF;

    RETURN ncad;

  END;
$$;
 4   DROP FUNCTION public.f_regresa_cadena(cadena text);
       public          postgres    false                       1255    32838 #   f_regresa_char(text, text, integer)    FUNCTION     ?  CREATE FUNCTION public.f_regresa_char(palabra text, letra text, posicion integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
   cad            TEXT;
   valcad      TEXT;
   nsize         INT;
   cadena    TEXT;
   BEGIN
   cadena = UPPER(palabra);
   nsize = LENGTH(cadena);
       /**Si el caracter que se regresa es una consonante **/
    IF letra = 'C'  THEN
               cadena = SUBSTR(cadena,2,nsize);
      cadena =REPLACE(REPLACE( REPLACE(REPLACE(REPLACE(cadena,'A'),'E',''),'I',''),'O',''),'U','');
      cadena= SUBSTR(cadena,posicion,1);
    ELSE
       /**Si el caracter que se regresa es una vocal **/

            FOR i IN 1..nsize LOOP
         cad = SUBSTR(cadena,(i+1)::INT,1 );
         IF cad IN ('A','E','I','O','U') THEN
            valcad = valcad||cad;
         END IF;
      END LOOP;
         cadena= SUBSTR(valcad,posicion,1);
    END IF;
    IF cadena IS NULL THEN
       RETURN 'X';
    ELSE
     RETURN cadena;
    END IF;
  END;
$$;
 Q   DROP FUNCTION public.f_regresa_char(palabra text, letra text, posicion integer);
       public          postgres    false            ?            1255    32839    f_tgr_liquidaciones_folio()    FUNCTION     ?   CREATE FUNCTION public.f_tgr_liquidaciones_folio() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        NEW.folio := 'L'||NEW.iniciales_tramite||TO_CHAR(NOW(),'YYYY')||LPAD(NEW.id_liquidacion::text, 20, '0');

        RETURN NEW;
    END;
$$;
 2   DROP FUNCTION public.f_tgr_liquidaciones_folio();
       public          postgres    false            ?            1255    32840    f_tgr_polizas_folio()    FUNCTION     ?   CREATE FUNCTION public.f_tgr_polizas_folio() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
        NEW.folio := 'P'||TO_CHAR(NOW(),'YYYY')||LPAD(NEW.id_poliza::text, 10, '0');
        RETURN NEW;
    END;
$$;
 ,   DROP FUNCTION public.f_tgr_polizas_folio();
       public          postgres    false            ?            1255    32841    f_tgr_predios_valor_catastral()    FUNCTION     ?   CREATE FUNCTION public.f_tgr_predios_valor_catastral() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
        NEW.valor_catastral := coalesce(NEW.valor_terreno,0) + coalesce(NEW.valor_construccion,0);

        RETURN NEW;
    END;
$$;
 6   DROP FUNCTION public.f_tgr_predios_valor_catastral();
       public          postgres    false                       1255    32842    f_traslado_propietarios()    FUNCTION     ?  CREATE FUNCTION public.f_traslado_propietarios() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
    exist int;
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            IF (OLD.es_propietario = 1) THEN
                DELETE FROM traslado_propietarios WHERE id_compareciente = OLD.id_compareciente AND id_traslado = OLD.id_traslado;
            END IF;
            RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            SELECT 1 INTO exist FROM traslado_propietarios WHERE id_compareciente = NEW.id_compareciente AND id_traslado = NEW.id_traslado;

            IF (NEW.es_propietario = 1) THEN
                IF (exist IS NULL) THEN
                    INSERT INTO traslado_propietarios (id_traslado, id_compareciente, agregadopor, fechaagregado, status) VALUES (NEW.id_traslado, NEW.id_compareciente,NEW.agregadopor,NOW(),1);
                END IF;
            ELSE
                IF (exist = 1) THEN
                    DELETE FROM traslado_propietarios WHERE id_compareciente = NEW.id_compareciente AND id_traslado = NEW.id_traslado;
                END IF;
            END IF;

            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            IF (NEW.es_propietario = 1) THEN
                INSERT INTO traslado_propietarios (id_traslado, id_compareciente, agregadopor, fechaagregado, status) VALUES (NEW.id_traslado, NEW.id_compareciente,NEW.agregadopor,NOW(),1);
            END IF;
            RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$$;
 0   DROP FUNCTION public.f_traslado_propietarios();
       public          postgres    false                       1255    32843    if_modified_func()    FUNCTION     ?  CREATE FUNCTION public.if_modified_func() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pg_catalog', 'audit', 'public'
    AS $$
DECLARE
    v_old_data TEXT;
    v_new_data TEXT;
BEGIN
    /* This dance with casting the NEW and OLD values to a ROW is not necessary in pg 9.0+ */
    SET TIME ZONE 'America/Mexico_city';

    IF (TG_OP = 'UPDATE') THEN
        v_old_data := row_to_json(OLD);
        v_new_data := row_to_json(NEW);
        INSERT INTO audit_tablas (schema_name,table_name,user_name,action_tstamp,action,original_data,new_data,query)
        VALUES (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,NOW() at time zone 'America/Mexico_city',substring(TG_OP,1,1),v_old_data,v_new_data, current_query());
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        v_old_data := row_to_json(OLD);
        INSERT INTO audit_tablas (schema_name,table_name,user_name,action_tstamp,action,original_data,query)
        VALUES (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,NOW() at time zone 'America/Mexico_city',substring(TG_OP,1,1),v_old_data, current_query());
        RETURN OLD;
    ELSIF (TG_OP = 'INSERT') THEN
        v_new_data := row_to_json(NEW);
        INSERT INTO audit_tablas (schema_name,table_name,user_name,action_tstamp,action,new_data,query)
        VALUES (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,NOW() at time zone 'America/Mexico_city',substring(TG_OP,1,1),v_new_data, current_query());
        RETURN NEW;
    ELSE
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - Other action occurred: %, at %',TG_OP,now() at time zone 'America/Mexico_city';
        RETURN NULL;
    END IF;
 
EXCEPTION
    WHEN data_exception THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [DATA EXCEPTION] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN unique_violation THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [UNIQUE] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN OTHERS THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [OTHER] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
END;
$$;
 )   DROP FUNCTION public.if_modified_func();
       public          postgres    false                       1255    32844    if_modified_ingresos()    FUNCTION     ?  CREATE FUNCTION public.if_modified_ingresos() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pg_catalog', 'audit', 'public'
    AS $$
DECLARE
    v_old_data TEXT;
    v_new_data TEXT;
BEGIN
    /* This dance with casting the NEW and OLD values to a ROW is not necessary in pg 9.0+ */
    SET TIME ZONE 'America/Mexico_city';

    IF (TG_OP = 'UPDATE') THEN
        v_old_data := row_to_json(OLD);
        v_new_data := row_to_json(NEW);
        INSERT INTO audit_tablas_ingresos (schema_name,table_name,user_name,action_tstamp,action,original_data,new_data,query)
        VALUES (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,NOW() at time zone 'America/Mexico_city',substring(TG_OP,1,1),v_old_data,v_new_data, current_query());
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        v_old_data := row_to_json(OLD);
        INSERT INTO audit_tablas_ingresos (schema_name,table_name,user_name,action_tstamp,action,original_data,query)
        VALUES (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,NOW() at time zone 'America/Mexico_city',substring(TG_OP,1,1),v_old_data, current_query());
        RETURN OLD;
    ELSIF (TG_OP = 'INSERT') THEN
        v_new_data := row_to_json(NEW);
        INSERT INTO audit_tablas_ingresos (schema_name,table_name,user_name,action_tstamp,action,new_data,query)
        VALUES (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,NOW() at time zone 'America/Mexico_city',substring(TG_OP,1,1),v_new_data, current_query());
        RETURN NEW;
    ELSE
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - Other action occurred: %, at %',TG_OP,now() at time zone 'America/Mexico_city';
        RETURN NULL;
    END IF;

EXCEPTION
    WHEN data_exception THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [DATA EXCEPTION] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN unique_violation THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [UNIQUE] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN OTHERS THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [OTHER] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
END;
$$;
 -   DROP FUNCTION public.if_modified_ingresos();
       public          postgres    false                       1255    32845    if_modified_sist()    FUNCTION     ?  CREATE FUNCTION public.if_modified_sist() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pg_catalog', 'audit', 'public'
    AS $$
DECLARE
    v_old_data TEXT;
    v_new_data TEXT;
BEGIN
    /* This dance with casting the NEW and OLD values to a ROW is not necessary in pg 9.0+ */
    SET TIME ZONE 'America/Mexico_city';

    IF (TG_OP = 'UPDATE') THEN
        v_old_data := row_to_json(OLD);
        v_new_data := row_to_json(NEW);
        INSERT INTO audit_tablas_sist (schema_name,table_name,user_name,action_tstamp,action,original_data,new_data,query)
        VALUES (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,NOW() at time zone 'America/Mexico_city',substring(TG_OP,1,1),v_old_data,v_new_data, current_query());
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        v_old_data := row_to_json(OLD);
        INSERT INTO audit_tablas_sist (schema_name,table_name,user_name,action_tstamp,action,original_data,query)
        VALUES (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,NOW() at time zone 'America/Mexico_city',substring(TG_OP,1,1),v_old_data, current_query());
        RETURN OLD;
    ELSIF (TG_OP = 'INSERT') THEN
        v_new_data := row_to_json(NEW);
        INSERT INTO audit_tablas_sist (schema_name,table_name,user_name,action_tstamp,action,new_data,query)
        VALUES (TG_TABLE_SCHEMA::TEXT,TG_TABLE_NAME::TEXT,session_user::TEXT,NOW() at time zone 'America/Mexico_city',substring(TG_OP,1,1),v_new_data, current_query());
        RETURN NEW;
    ELSE
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - Other action occurred: %, at %',TG_OP,now() at time zone 'America/Mexico_city';
        RETURN NULL;
    END IF;

EXCEPTION
    WHEN data_exception THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [DATA EXCEPTION] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN unique_violation THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [UNIQUE] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN OTHERS THEN
        RAISE WARNING '[AUDIT.IF_MODIFIED_FUNC] - UDF ERROR [OTHER] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
END;
$$;
 )   DROP FUNCTION public.if_modified_sist();
       public          postgres    false                       1255    32846    ing_cobros_det_aft_ins()    FUNCTION     T  CREATE FUNCTION public.ing_cobros_det_aft_ins() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    vMaxMonto numeric;
    vMaxID INT;
    vFormaPago varchar(50);
    vData3 text;
BEGIN
      IF TG_OP = 'INSERT' THEN
        SELECT max(pago_monto) INTO vMaxMonto FROM ing_cobros_det WHERE masterhash=NEW.masterhash;
        SELECT max(id_cobro_det) INTO vMaxID FROM ing_cobros_det WHERE pago_monto=vMaxMonto AND masterhash=NEW.masterhash;
        SELECT cve_forma_pago, data_3 INTO vFormaPago, vData3 FROM ing_cobros_det WHERE id_cobro_det=vMaxID;
        IF vFormaPago = '04' THEN
            if vData3='debito' THEN
                vFormaPago:='28';
            end if;
        end if;
        UPDATE ing_cobros SET recibo_forma_pago=vFormaPago WHERE masterhash=NEW.masterhash;
        RETURN NEW;
      END IF;
      RETURN NEW;
    END;
$$;
 /   DROP FUNCTION public.ing_cobros_det_aft_ins();
       public          postgres    false                       1255    32847    ing_cobros_dlm()    FUNCTION     ?  CREATE FUNCTION public.ing_cobros_dlm() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    vIdControl INT;
    vTipoCaja INT;
BEGIN
      IF TG_OP = 'INSERT' THEN
        SELECT tipo INTO vTipoCaja FROM cat_cajas where id_caja = NEW.id_caja;
        IF (NEW.id_control_caja=0 AND (NEW.id_caja=0 OR vTipoCaja=2)) THEN
            SELECT max(id_control_caja) INTO vIdControl from ing_control_caja where id_caja=NEW.id_caja AND date(fechaagregado)=date(NOW());
            IF vIdControl>0 and  vIdControl is not null THEN
                NEW.id_control_caja=vIdControl;
            ELSE
                INSERT INTO ing_control_caja (id_caja, id_cajero, hora_apertura, id_usuario_apertura, monto_apertura, hora_corte, id_usuario_corte, hora_cierre, id_usuario_cierre,  agregadopor, fechaagregado, status, hora_solicitud_apertura, hash)
                VALUES (NEW.id_caja, NEW.id_cajero, NOW(), 0, 0, NOW(), 0, NOW(), 0, 0, NOW(), 3, NOW(), CONCAT(CONCAT(MD5(CONCAT(NEW.id_caja,to_char(now(),'YYYYMMDDHH24MISS'))),'_'),MD5(CONCAT(NEW.id_caja,''))))
                RETURNING id_control_caja INTO NEW.id_control_caja;
            end if;
        end if;

        IF NEW.recibo_serie = 'TB' THEN
            NEW.recibo_forma_pago = '03';
        END IF;
        RETURN NEW;
      ELSIF TG_OP = 'UPDATE' THEN
        IF NEW.recibo_serie = 'TB' THEN
            NEW.recibo_forma_pago = '03';
        END IF;
       RETURN NEW;
      ELSIF TG_OP = 'DELETE' THEN
       RETURN NULL;
      END IF;
      RETURN NEW;
    END;
$$;
 '   DROP FUNCTION public.ing_cobros_dlm();
       public          postgres    false                       1255    32848    inpc_vw_dml()    FUNCTION     ?  CREATE FUNCTION public.inpc_vw_dml() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
      IF TG_OP = 'INSERT' THEN
        INSERT INTO inpc (ano, mes, factor, agregadopor, fechaagregado, status)
             VALUES(NEW.ano, NEW.mes, NEW.factor, NEW.agregadopor, NEW.fechaagregado, NEW.status)
        RETURNING id_inpc INTO NEW.id_inpc;
        RETURN NEW;
      ELSIF TG_OP = 'UPDATE' THEN
       UPDATE inpc SET ano=NEW.ano, mes=NEW.mes, factor=NEW.factor, status=NEW.status WHERE id_inpc=OLD.id_inpc;
       RETURN NEW;
      ELSIF TG_OP = 'DELETE' THEN
       UPDATE inpc SET status=0 WHERE id_inpc=OLD.id_inpc;
       RETURN NULL;
      END IF;
      RETURN NEW;
    END;
$$;
 $   DROP FUNCTION public.inpc_vw_dml();
       public          postgres    false                       1255    32849 '   predial_porcentaje_tipo_predio_vw_dml()    FUNCTION     "  CREATE FUNCTION public.predial_porcentaje_tipo_predio_vw_dml() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
      IF TG_OP = 'INSERT' THEN
        INSERT INTO predial_porcentaje_tipo_predio (id_tipo_predio, anio, porcentaje_edif, porcentaje_bald, agregadopor, fechaagregado, status)
             VALUES(NEW.id_tipo_predio, NEW.anio, NEW.porcentaje_edif, NEW.porcentaje_bald, NEW.agregadopor, NEW.fechaagregado, NEW.status)
        RETURNING id_porcentaje_tipo_predio INTO NEW.id_porcentaje_tipo_predio;
        RETURN NEW;
      ELSIF TG_OP = 'UPDATE' THEN
       UPDATE predial_porcentaje_tipo_predio SET id_tipo_predio=NEW.id_tipo_predio, anio=NEW.anio, porcentaje_edif=NEW.porcentaje_edif, porcentaje_bald=NEW.porcentaje_bald, status=NEW.status WHERE id_porcentaje_tipo_predio=OLD.id_porcentaje_tipo_predio;
       RETURN NEW;
      ELSIF TG_OP = 'DELETE' THEN
       UPDATE predial_porcentaje_tipo_predio SET status=0 WHERE id_porcentaje_tipo_predio=OLD.id_porcentaje_tipo_predio;
       RETURN NULL;
      END IF;
      RETURN NEW;
    END;
$$;
 >   DROP FUNCTION public.predial_porcentaje_tipo_predio_vw_dml();
       public          postgres    false                       1255    32850 )   pruebaFuncion(character varying, integer)    FUNCTION     ?D  CREATE FUNCTION public."pruebaFuncion"(pcve_catastral character varying DEFAULT 'N/A'::character varying, "pPeriodo" integer DEFAULT 0) RETURNS TABLE(cve_catastral character varying, fecha_fin_bim timestamp without time zone, anio_base integer, periodo_base integer, anio_topado integer, calc_base_gravable text, calc_area_constr text, flag_predio_topado integer, pago_anterior numeric, calc_id_tipo_predio integer, calc_tipo_valor integer, id_estado integer, id_municipio integer, valor_uma numeric, flag_acuerdo_cabildo integer, fechaini timestamp without time zone, cve_traslanet character varying, clave_gob_edo text, flag_anio_completo integer, montos_bimestrales_pens numeric, flag_calculo_tercera_edad integer, bimestre_vencido integer, fecha_venc text, fecha_calculo date)
    LANGUAGE plpgsql
    AS $_$
#variable_conflict use_column
	DECLARE v_fecha_calculo DATE DEFAULT NOW()::DATE;
	DECLARE v_fechaini TIMESTAMP DEFAULT (NOW()::DATE)::TIMESTAMP;
	DECLARE v_base_calculo_predial VARCHAR DEFAULT (SELECT LOWER(valor) FROM variables WHERE etiqueta = 'PREDIAL_APLICAR_REDUCC_CALCULO_ACCESORIOS' AND status = 1); /*1.1*/
	DECLARE v_flag_pae INT DEFAULT (SELECT COALESCE((SELECT status FROM predial_config_calculo WHERE  NOW() BETWEEN vigencia_ini AND vigencia_fin AND clave_proceso = 'PRED_GEJE' AND status = 1), 0)::INT); /*1.2*/
	DECLARE v_flag_embargo INT DEFAULT (SELECT COALESCE((SELECT status FROM predial_config_calculo WHERE  NOW() BETWEEN vigencia_ini AND vigencia_fin AND clave_proceso = 'PRED_GEMB' AND status = 1), 0)::INT); /*1.3*/
	DECLARE v_resultActualizacion INT DEFAULT (SELECT COALESCE((SELECT status FROM predial_config_calculo WHERE  NOW() BETWEEN vigencia_ini AND vigencia_fin AND clave_proceso = 'PRED_ACT' AND status = 1), 0)::INT); /*1.4*/
	DECLARE v_flag_desc_pens_activo INT DEFAULT (SELECT COALESCE((SELECT status FROM predial_config_calculo WHERE  NOW() BETWEEN vigencia_ini AND vigencia_fin AND clave_proceso = 'PRED_DESC_PENS' AND status = 1), 0)::INT); /*1.5*/
BEGIN

	--Eliminamos tabla temporal temp_cat_predios
	DROP TABLE IF EXISTS temp_cat_predios;
	DROP TABLE IF EXISTS temp_datos_predio;
	DROP TABLE IF EXISTS temp_anios_topados;
	DROP TABLE IF EXISTS temp_datos_base_cat;
	--DROP TABLE IF EXISTS temp_distinct_cve_traslanet;
	--DROP TABLE IF EXISTS temp_conceptos_recaudacion;
	--DROP TABLE IF EXISTS temp_camp_descuentos;
	DROP TABLE IF EXISTS temp_periodos;
	DROP TABLE IF EXISTS temp_periodos_cve_catastral;	

IF $1 = 'N/A' THEN
CREATE TEMP TABLE temp_cat_predios AS
SELECT p.cve_catastral 
FROM cat_predios p 
WHERE predial_ult_periodo_pago::INT < $2 
			AND status = 1 
			AND flag_requiere_aclaracion = 0;						
ELSE		
CREATE TEMP TABLE temp_cat_predios AS
SELECT p.cve_catastral 
FROM cat_predios p 
WHERE predial_ult_periodo_pago::INT < $2 
			AND status = 1 
			AND flag_requiere_aclaracion = 0
			AND cve_catastral = $1;
			
END IF;
													--'010100101003220';
													--'010506586238728';
													--'010100101001003';
													--'010106401052006';		
											

CREATE TEMP TABLE temp_anios_topados AS
SELECT token AS anio_topado from variables v, unnest(string_to_array(v.valor, ',')) s(token)  WHERE etiqueta = 'ANIOS_TOPADOS';


CREATE TEMP TABLE temp_datos_predio AS
SELECT *, 
			 CASE WHEN	bimestre_ult_pago = 6 AND flag_desc_pens_activo = 1 AND flag_tercera_edad = 1 AND anio_ult_pago::int = (date_part('year', now())-1) AND flag_anio_completo = 1 
					  THEN 1 
						ELSE 0 
						END flag_calculo_tercera_edad
FROM	(SELECT *, 
						 CASE WHEN anio_ini < anio_fin AND periodo_fin = 6 
								  THEN 1 
								  WHEN anio_ini = anio_fin AND periodo_ini = 1 AND periodo_fin = 6 
								  THEN 1 
								  ELSE 0 
								  END flag_anio_completo			 
			FROM	(SELECT *,
									 SUBSTRING(periodo_ini_completo,1,4) anio_ini,
									 SUBSTRING(periodo_ini_completo,5,2)::INT * 1 periodo_ini, 
									 SUBSTRING(periodo_fin_completo::VARCHAR,1,4) anio_fin, 
									 SUBSTRING(periodo_fin_completo::VARCHAR,5,2)::INT * 1 periodo_fin  
				    FROM	(SELECT *, 
												  CASE WHEN bimestre_ult_pago = 6 
												  THEN (anio_ult_pago::INT + 1) ||'01' 
												  ELSE anio_ult_pago ||'0'|| (bimestre_ult_pago + 1) 
												  END periodo_ini_completo,
												  $2 periodo_fin_completo
									FROM (SELECT cve_catastral,
															 predial_ult_periodo_pago ult_periodo_pago, 
															 SUBSTRING(predial_ult_periodo_pago,1,4) anio_ult_pago,
															 SUBSTRING(predial_ult_periodo_pago,5,2)::INT * 1 bimestre_ult_pago,
															 flag_requiere_aclaracion,
															 flag_tercera_edad,
															 status,
															 (SELECT flag_sin_beneficios from cat_contribuyentes where id_contribuyente=(SELECT id_contribuyente from cat_predios_propietarios where id_predio=cp.id_predio)) flag_sin_beneficios,
															 (SELECT uso_predio from catastral_base where cve_cat = cp.cve_catastral) uso_predio,
															 cp.flag_acuerdo_cabildo,cp.obervacion_especial,
															 (flag_pae::INT * /*1.2*/ v_flag_pae) as flag_pae,
															 (flag_embargo::INT * /*1.3*/ v_flag_embargo) as flag_embargo,										
															 /*1.5*/ v_flag_desc_pens_activo AS flag_desc_pens_activo
											 FROM cat_predios cp
											 WHERE cve_catastral IN (SELECT p.cve_catastral FROM temp_cat_predios p) 
											 AND (predial_ult_periodo_pago <> '' OR predial_ult_periodo_pago IS NOT NULL)
											 ) T0
								  WHERE (T0.uso_predio NOT IN ('PRGO') OR T0.uso_predio IS NULL)
									) T1
						WHERE periodo_fin_completo > periodo_ini_completo::INT
						) T2
			) T3;

--CREATE INDEX temp_datos_predio_cve_catastral_index ON temp_datos_predio (cve_catastral);

CREATE TEMP TABLE temp_datos_base_cat AS
SELECT * , 
			 CASE WHEN flag_predio_topado = 1 AND (SELECT count(anio_topado) from temp_anios_topados WHERE anio_topado::int = date_part('year', now())) >= 1 
			 THEN (SELECT COALESCE(impuesto_topado,0) FROM predial_topes_anuales WHERE cve_catastral = cve_cat AND DATE(NOW()) <= date(fecha) ORDER BY fecha DESC LIMIT 1) 
			 ELSE 0 						
			 END pago_anterior,
			 CASE WHEN clave_gob_edo = 'R' 
			 THEN 'Has.' 
			 ELSE 'm<sup>2</sup>' 
			 END predio_unidad_medida,
			 CASE WHEN flag_predio_topado = 1
			 THEN CASE WHEN base_gravable_aux IS NULL OR base_gravable_aux = ''
						THEN valor_catastral
						ELSE base_gravable_aux
						END
			  ELSE valor_catastral
				END AS base_gravable,				
				CASE WHEN cve_traslanet_aux = 'IPU'
				THEN cve_traslanet_aux || CASE WHEN COALESCE(ac::DECIMAL,0) > 0 
																	THEN 'E' 
																	ELSE 'B' 
																	END
				ELSE cve_traslanet_aux
				END cve_traslanet
FROM	(SELECT id_catastral_base, rfc, fecha_proceso, cve_cat, 
							CASE WHEN propietario IS NULL OR propietario = '' 
							THEN 'Sin datos' 
							ELSE propietario 
							END AS propietario,
							id_municipio, 
							(SELECT id_estado from cat_municipios where id_municipio=cb.id_municipio) id_estado,
							col_pred, calle_pred, num_ext_pred, num_int_pred, col_prop, calle_prop, num_ext_prop, num_int_prop, tel, cve_anterior, 
							COALESCE(NULLIF(valor_ter_ant,'') ,'0') AS valor_ter_ant, 
							COALESCE(NULLIF(valor_cons_ant,'') ,'0') AS valor_cons_ant, 
							COALESCE(NULLIF(valor_ter,'') ,'0') AS valor_ter, 
							COALESCE(NULLIF(valor_cons,'') ,'0') AS valor_cons, 
							COALESCE(NULLIF(valor_catastral,'') ,'0') AS valor_catastral, 
							COALESCE(NULLIF(at,'') ,'0') AS at,  
							COALESCE(NULLIF(ac,'') ,'0') AS ac, 
							fecha_alta,
							(SELECT id_tipo_predio FROM cat_tipo_predio WHERE clave_gob_edo = trim(concat(trim(cb.tipo_pred),' ',trim(cb.uso_predio))))  id_tipo_predio,
							(SELECT tipo_predio FROM cat_tipo_predio WHERE clave_gob_edo = trim(concat(trim(cb.tipo_pred),' ',trim(cb.uso_predio)))) tipo_pred,
							(SELECT cve_traslanet FROM cat_tipo_predio WHERE clave_gob_edo = trim(concat(trim(cb.tipo_pred),' ',trim(cb.uso_predio)))) cve_traslanet_aux,
							f_get_domicilio_catastral_base(id_catastral_base) domicilio, fechaagregado::TIMESTAMP fecha_val_act,
							trim(concat(trim(cb.tipo_pred),' ',trim(cb.uso_predio))) clave_gob_edo,
							(SELECT abreviatura from cat_estados where id_estado =estado_prop) estado_prop,
							(SELECT nombre from cat_municipios where id_municipio = municipio_prop) municipio_prop,
							(SELECT valor_catastral from catastral_kardex_det where cve_cat=cb.cve_cat and (date_part('year', now())::VARCHAR || '-12-31')::DATE BETWEEN date(fechaagregado) AND date(fecha_insert_registro) ORDER BY to_number(valor_catastral, 'L9G999g9999.9999') DESC LIMIT 1) base_gravable_aux,
							(SELECT flag_predio_topado FROM predial_topes_anuales WHERE cve_catastral=cb.cve_cat and DATE(NOW()) <= date(fecha) ORDER BY fecha DESC LIMIT 1) flag_predio_topado				
			FROM catastral_base cb
			WHERE cve_cat IN (SELECT p.cve_catastral FROM temp_datos_predio p)
			)T0;

--CREATE INDEX temp_datos_base_cat_cve_cve_cat_index ON temp_datos_base_cat (cve_cat);

/*
CREATE TEMP TABLE temp_distinct_cve_traslanet AS
SELECT cve 
FROM (SELECT string_agg(cve_traslanet, ',') || ',ACT' || ',IEOPM' || ',RECP' || ',MUL' || ',DPENS' || ',GEJE' || ',GEMB' || ',REDPRED' || ',DPREDENE' || ',DPREDFEB' as val 
			FROM (SELECT DISTINCT cve_traslanet 
						FROM temp_datos_base_cat
					 )TAUX
		 )TAUX2, unnest(string_to_array(TAUX2.val, ','))	s(cve);
*/

/*
CREATE TEMP TABLE temp_conceptos_recaudacion AS
SELECT cve_traslanet, id_concepto_recaudacion, descripcion, f_get_concepto_recaudacion(id_concepto_recaudacion) cve_concepto_recaudacion
FROM cat_ingresos_concepto_recaudacion
WHERE anio = date_part('year', now())
AND status = 1
AND cve_traslanet IN (SELECT cve FROM temp_distinct_cve_traslanet);
*/

/*
CREATE TEMP TABLE temp_camp_descuentos AS
SELECT id_campana_descuento_det, concepto_recaudacion, descuento_monto, descuento_porc, cve_traslanet_importe,
			 (SELECT descripcion FROM cat_ingresos_concepto_recaudacion WHERE f_get_concepto_recaudacion(id_concepto_recaudacion)=cdd.concepto_recaudacion AND anio = to_char(NOW(), 'YYYY')::INT) concepto,
			 (SELECT id_concepto_recaudacion FROM cat_ingresos_concepto_recaudacion WHERE f_get_concepto_recaudacion(id_concepto_recaudacion) = cdd.concepto_recaudacion AND anio = to_char(NOW(), 'YYYY')::INT) id_concepto_recaudacion
FROM cat_campanas_descuento_det cdd
WHERE id_campana_descuento_det IN (SELECT MAX(id_campana_descuento_det)
																	 FROM cat_campanas_descuento_det cdd
																	 WHERE cve_traslanet_importe IN (SELECT cve FROM temp_distinct_cve_traslanet)
																	 AND NOW()::DATE BETWEEN vigencia_ini AND vigencia_fin AND status = 1
																	 GROUP BY cve_traslanet_importe); 
*/

CREATE TEMP TABLE temp_periodos as
SELECT anio_base, 
			 periodo_base,
			 anio_base::VARCHAR || '0' ||periodo_base::VARCHAR AS periodo_base_completo,
			 CASE WHEN anio_topado IS NULL
			 THEN 0
			 ELSE 1
			 END anio_topado
FROM	(SELECT * 
			 FROM generate_series((SELECT MIN(anio_ini) FROM temp_datos_predio)::INT,(SELECT MAX(anio_fin) FROM temp_datos_predio)::INT) AS anio_base, generate_series(1,6) periodo_base
			) T0	
			LEFT JOIN
			(SELECT * 
			 FROM temp_anios_topados
			) T1
			ON T1.anio_topado::INT = anio_base
ORDER BY anio_base,periodo_base;

CREATE INDEX temp_periodos_cve_periodo_base_completo_index ON temp_periodos (periodo_base_completo);



CREATE TEMP TABLE temp_periodos_cve_catastral as
SELECT T1.*,
						 to_char(fechafin, 'YYYY/MM/DD') AS fecha_venc, 
						 CASE WHEN fechaini > fechafin 
						 THEN 1 
						 ELSE 0 
						 END bimestre_vencido,
						 sm.sm AS valor_uma,
						 CASE WHEN flag_calculo_tercera_edad = 1 
						 THEN  sm.sm / 6 
						 ELSE 0 
						 END montos_bimestrales_pens,
						 v_base_calculo_predial /*1.1*/ AS base_calculo_predial,
						 v_resultActualizacion /*1.4*/  AS resultActualizacion
			FROM (SELECT *,
									 fecha_limite::TIMESTAMP AS fecha_fin_bim, 
									 (fecha_limite::DATE + INTERVAL '15 day')::TIMESTAMP AS fechafin
						FROM (SELECT tmpDP.*,tmpP.*,
												 v_fecha_calculo AS fecha_calculo, 
												 v_fechaini as fechaini, 
												 (date_trunc('MONTH', (tmpP.anio_base::VARCHAR || '-' || (tmpP.periodo_base * 2)::VARCHAR || '-01')::DATE) + INTERVAL '1 MONTH - 1 day')::DATE AS fecha_limite,			 
												 (tmpP.anio_base::VARCHAR || '-' ||((tmpP.periodo_base * 2) - 1)::VARCHAR || '-01')::TIMESTAMP AS fecha_ini_bim		
									FROM	temp_periodos tmpP
									INNER JOIN
									temp_datos_predio tmpDP ON (tmpP.periodo_base_completo::INT >= tmpDP.periodo_ini_completo::INT) AND (tmpP.periodo_base_completo::INT <= tmpDP.periodo_fin_completo)
									)T0
						)T1
					  LEFT JOIN sm ON T1.fecha_fin_bim::DATE BETWEEN sm.fecha::DATE AND sm.fecha_f::DATE AND sm.status = 1;	

		
	 RETURN query (SELECT cve_catastral,
												fecha_fin_bim,
												anio_base,
												periodo_base,
												anio_topado,
												COALESCE(NULLIF(valor_catastral_tmp2_aux,'') ,valor_catastral_tmp1_aux) AS calc_base_gravable,
												COALESCE(NULLIF(ac_tmp2_aux,'') ,ac_tmp1_aux) AS calc_area_constr,
												COALESCE(flag_predio_topado_tmp2_aux, flag_predio_topado_tmp1_aux) AS flag_predio_topado,
												COALESCE(impuesto_topado_tmp2_aux, pago_anterior_tmp1_aux) AS pago_anterior,
												COALESCE(id_tipo_predio_tmp2_aux, id_tipo_predio_tmp1_aux)::INT AS calc_id_tipo_predio,
												CASE WHEN fecha_fin_bim::DATE < fecha_val_act::DATE THEN 2 ELSE 1 END AS calc_tipo_valor,
												id_estado,
												id_municipio,
												valor_uma,
												flag_acuerdo_cabildo,
												fechaini,  --Revisar si es necesario agregarla ya que solo son las fechas actuales codigo php linea 1032 Predial.php
												cve_traslanet,
												clave_gob_edo,
												flag_anio_completo,
												montos_bimestrales_pens, --AS montos_bimestrales_pens_aux,
												flag_calculo_tercera_edad,
												bimestre_vencido,
												fecha_venc,
												fecha_calculo
												/*,CASE WHEN tmpCD.descuento_monto IS NOT NULL AND tmpCD.descuento_porc IS NOT NULL 
												THEN CASE WHEN tmpCD.descuento_monto > 0 THEN 'MONTO'
																	WHEN tmpCD.descuento_porc > 0 THEN 'PORC'
																	ELSE 'N/A'
														 END
												ELSE 'N/A'
												END	campana_descuento_calculo
												,tmpCD.**/						  	
										 FROM	((SELECT tmpPCC.cve_catastral,
																	 tmpPCC.fecha_fin_bim, 
																	 valor_catastral AS valor_catastral_tmp1_aux, 
																	 tmpDB.ac AS ac_tmp1_aux,
																	 tmpDB.flag_predio_topado AS flag_predio_topado_tmp1_aux,
																	 tmpDB.pago_anterior AS pago_anterior_tmp1_aux,
																	 tmpDB.id_tipo_predio AS id_tipo_predio_tmp1_aux,
																	 tmpPCC.anio_base,
																	 tmpPCC.periodo_base,
																	 tmpPCC.anio_topado,
																	 tmpDB.id_estado,
																	 tmpDB.id_municipio,
																	 tmpPCC.valor_uma,
																	 tmpDP.flag_acuerdo_cabildo,
																	 tmpPCC.fechaini,  --Revisar si es necesario agregarla ya que solo son las fechas actuales codigo php linea 1032 Predial.php
																	 tmpDB.cve_traslanet,
																	 tmpDB.clave_gob_edo,
																	 tmpDP.flag_anio_completo,
																	 tmpPCC.montos_bimestrales_pens,
																	 tmpPCC.flag_calculo_tercera_edad,
																	 tmpPCC.bimestre_vencido,
																	 tmpPCC.fecha_venc,
																	 tmpPCC.fecha_calculo,
																	 tmpDB.fecha_val_act
														FROM temp_periodos_cve_catastral tmpPCC 
														INNER JOIN temp_datos_predio tmpDP ON tmpDP.cve_catastral = tmpPCC.cve_catastral
														INNER JOIN temp_datos_base_cat tmpDB ON tmpDB.cve_cat = tmpPCC.cve_catastral							
													 )tmp1 
													LEFT JOIN LATERAL
													(SELECT valor_catastral AS valor_catastral_tmp2_aux,
																	ac AS ac_tmp2_aux, 
																	(SELECT flag_predio_topado FROM predial_topes_anuales WHERE cve_catastral = cb.cve_cat AND tmp1.fecha_fin_bim::DATE <= date(fecha) ORDER BY fecha LIMIT 1) flag_predio_topado_tmp2_aux, 
																	(SELECT impuesto_topado FROM predial_topes_anuales WHERE cve_catastral = cb.cve_cat AND tmp1.fecha_fin_bim::DATE <= date(fecha) ORDER BY fecha LIMIT 1) impuesto_topado_tmp2_aux, 
																	(SELECT id_tipo_predio FROM cat_tipo_predio WHERE clave_gob_edo = trim(concat(trim(cb.tipo_pred),' ',trim(cb.uso_predio)))) id_tipo_predio_tmp2_aux
													 FROM catastral_kardex_det cb
													 WHERE cve_cat = tmp1.cve_catastral
													 AND tmp1.fecha_fin_bim::DATE BETWEEN fechaagregado::DATE AND fecha_insert_registro::DATE 
													 ORDER BY fecha_insert_registro DESC
													 LIMIT 1
													)tmp2 ON TRUE
												 )T0);
												 /*LEFT JOIN temp_camp_descuentos tmpCD ON tmpCD.cve_traslanet_importe = T0.cve_traslanet 																					
																													 AND T0.flag_anio_completo = 1
																													 AND TRIM(T0.clave_gob_edo) <> 'F'
																													 AND anio_base = date_part('year', now());*/
END
$_$;
 \   DROP FUNCTION public."pruebaFuncion"(pcve_catastral character varying, "pPeriodo" integer);
       public          postgres    false                       1255    32852    sm_vw_dml()    FUNCTION     ?  CREATE FUNCTION public.sm_vw_dml() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
      IF TG_OP = 'INSERT' THEN
        INSERT INTO sm (fecha, fecha_f, sm, agregadopor, fechaagregado, status)
             VALUES(TO_TIMESTAMP(concat(NEW.fecha_i,' 00:00:00'),'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP(concat(NEW.fecha_f,' 23:59:59'),'YYYY-MM-DD HH24:MI:SS'), NEW.sm, NEW.agregadopor, NEW.fechaagregado, NEW.status)
        RETURNING id_salario INTO NEW.id_salario;
        RETURN NEW;
      ELSIF TG_OP = 'UPDATE' THEN
       UPDATE sm SET fecha=TO_TIMESTAMP(concat(NEW.fecha_i,' 00:00:00'),'YYYY-MM-DD HH24:MI:SS'), fecha_f=TO_TIMESTAMP(concat(NEW.fecha_f,' 23:59:59'),'YYYY-MM-DD HH24:MI:SS'), sm=NEW.sm, status=NEW.status WHERE id_salario=OLD.id_salario;
       RETURN NEW;
      ELSIF TG_OP = 'DELETE' THEN
       UPDATE sm SET status=0 WHERE id_salario=OLD.id_salario;
       RETURN NULL;
      END IF;
      RETURN NEW;
    END;
$$;
 "   DROP FUNCTION public.sm_vw_dml();
       public          postgres    false                       1255    32853    updt_nombre_completo_cont()    FUNCTION     ?   CREATE FUNCTION public.updt_nombre_completo_cont() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

    NEW.nombre_completo=trim(CONCAT(NEW.ap_paterno, ' ' , NEW.ap_materno, ' ', NEW.nombre));
    RETURN NEW;
END;
$$;
 2   DROP FUNCTION public.updt_nombre_completo_cont();
       public          postgres    false                       1255    32854    updt_total_liquidacion()    FUNCTION     S  CREATE FUNCTION public.updt_total_liquidacion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

    IF (TG_OP = 'DELETE') THEN
        UPDATE liquidaciones SET total=(SELECT SUM(importe) FROM liquidaciones_det WHERE id_liquidacion=OLD.id_liquidacion) WHERE id_liquidacion=OLD.id_liquidacion;
        RETURN OLD;
    ELSIF (TG_OP = 'UPDATE' OR TG_OP = 'INSERT') THEN
        UPDATE liquidaciones SET total=(SELECT SUM(importe) FROM liquidaciones_det WHERE id_liquidacion=NEW.id_liquidacion) WHERE id_liquidacion=NEW.id_liquidacion;
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$;
 /   DROP FUNCTION public.updt_total_liquidacion();
       public          postgres    false            ?            1259    35170    books_purchases    TABLE       CREATE TABLE public.books_purchases (
    id_book_purchase integer NOT NULL,
    id_property integer NOT NULL,
    total_bricks integer NOT NULL,
    create_date timestamp with time zone NOT NULL,
    expiration_date timestamp with time zone NOT NULL,
    valid integer NOT NULL
);
 #   DROP TABLE public.books_purchases;
       public         heap    postgres    false            ?            1259    35168 $   books_purchases_id_book_purchase_seq    SEQUENCE     ?   CREATE SEQUENCE public.books_purchases_id_book_purchase_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.books_purchases_id_book_purchase_seq;
       public          postgres    false    222            ?           0    0 $   books_purchases_id_book_purchase_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.books_purchases_id_book_purchase_seq OWNED BY public.books_purchases.id_book_purchase;
          public          postgres    false    221            ?            1259    33123 '   cat_ingresos_clase_id_clase_ingreso_seq    SEQUENCE     ?   CREATE SEQUENCE public.cat_ingresos_clase_id_clase_ingreso_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.cat_ingresos_clase_id_clase_ingreso_seq;
       public          postgres    false            ?            1259    33447 &   catrastral_base_id_catrastral_base_seq    SEQUENCE     ?   CREATE SEQUENCE public.catrastral_base_id_catrastral_base_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.catrastral_base_id_catrastral_base_seq;
       public          postgres    false            ?            1259    33449 2   catrastral_kardex_det_id_catrastral_kardex_det_seq    SEQUENCE     ?   CREATE SEQUENCE public.catrastral_kardex_det_id_catrastral_kardex_det_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 I   DROP SEQUENCE public.catrastral_kardex_det_id_catrastral_kardex_det_seq;
       public          postgres    false            ?            1259    32947    id_banco_pk_seq    SEQUENCE     x   CREATE SEQUENCE public.id_banco_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.id_banco_pk_seq;
       public          postgres    false            ?            1259    33575    id_tarjeta_pk_seq    SEQUENCE     z   CREATE SEQUENCE public.id_tarjeta_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.id_tarjeta_pk_seq;
       public          postgres    false            ?            1259    35126 
   properties    TABLE       CREATE TABLE public.properties (
    id_properties integer NOT NULL,
    name character varying NOT NULL,
    type character varying NOT NULL,
    city character varying NOT NULL,
    risk_level character varying NOT NULL,
    delivery_estimated_date date,
    proyect_status character varying NOT NULL,
    total_bricks integer NOT NULL,
    available_bricks integer NOT NULL,
    price_brick numeric(30,2) NOT NULL,
    estimated_rent_year numeric(30,2) NOT NULL,
    image character varying NOT NULL,
    bricks_to_buy integer
);
    DROP TABLE public.properties;
       public         heap    postgres    false            ?            1259    35124    properties_id_properties_seq    SEQUENCE     ?   CREATE SEQUENCE public.properties_id_properties_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.properties_id_properties_seq;
       public          postgres    false    216            ?           0    0    properties_id_properties_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.properties_id_properties_seq OWNED BY public.properties.id_properties;
          public          postgres    false    215            ?            1259    35137 	   purchases    TABLE     <  CREATE TABLE public.purchases (
    id_purchases integer NOT NULL,
    id_properties integer NOT NULL,
    id_user integer NOT NULL,
    total numeric(30,2) NOT NULL,
    total_bricks integer NOT NULL,
    id_authorization character varying NOT NULL,
    date date NOT NULL,
    status character varying NOT NULL
);
    DROP TABLE public.purchases;
       public         heap    postgres    false            ?            1259    35135    purchases_id_purchases_seq    SEQUENCE     ?   CREATE SEQUENCE public.purchases_id_purchases_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.purchases_id_purchases_seq;
       public          postgres    false    218            ?           0    0    purchases_id_purchases_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.purchases_id_purchases_seq OWNED BY public.purchases.id_purchases;
          public          postgres    false    217            ?            1259    35157    users    TABLE     ?   CREATE TABLE public.users (
    id_user integer NOT NULL,
    username character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    create_at timestamp with time zone NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            ?            1259    35155    users_id_user_seq    SEQUENCE     ?   CREATE SEQUENCE public.users_id_user_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_id_user_seq;
       public          postgres    false    220            ?           0    0    users_id_user_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_id_user_seq OWNED BY public.users.id_user;
          public          postgres    false    219            ?            1259    34162    vw_cat_contrib_flag_sin_benef    VIEW     ?   CREATE VIEW public.vw_cat_contrib_flag_sin_benef AS
 SELECT 1 AS flag_sin_beneficios,
    'Sin Beneficios'::text AS descripcion,
    1 AS status
UNION
 SELECT 0 AS flag_sin_beneficios,
    'Con Beneficios'::text AS descripcion,
    1 AS status;
 0   DROP VIEW public.vw_cat_contrib_flag_sin_benef;
       public          postgres    false            ?            1259    34209    vw_cat_tipo_tarifa    VIEW     ?   CREATE VIEW public.vw_cat_tipo_tarifa AS
 SELECT 1 AS id_tipo_tarifa,
    'Cobro tradicional'::text AS tipo_tarifa,
    1 AS status
UNION
 SELECT 2 AS id_tipo_tarifa,
    'Tarifa progresiva'::text AS tipo_tarifa,
    1 AS status;
 %   DROP VIEW public.vw_cat_tipo_tarifa;
       public          postgres    false            ?            1259    34222    vw_cc_regimen_fiscal    VIEW     ~  CREATE VIEW public.vw_cc_regimen_fiscal AS
 SELECT 'PF'::text AS regimen_fiscal,
    'PERSONA FISICA'::text AS desc_regimen_fiscal,
    1 AS status
UNION
 SELECT 'PM'::text AS regimen_fiscal,
    'PERSONA MORAL'::text AS desc_regimen_fiscal,
    1 AS status
UNION
 SELECT 'PFAE'::text AS regimen_fiscal,
    'PERSONA FISICA ACT. EMP.'::text AS desc_regimen_fiscal,
    1 AS status;
 '   DROP VIEW public.vw_cc_regimen_fiscal;
       public          postgres    false            ?            1259    34226 
   vw_cc_sexo    VIEW     ?   CREATE VIEW public.vw_cc_sexo AS
 SELECT 'H'::text AS sexo,
    'Hombre'::text AS desc_sexo,
    1 AS status
UNION
 SELECT 'M'::text AS sexo,
    'Mujer'::text AS desc_sexo,
    1 AS status;
    DROP VIEW public.vw_cc_sexo;
       public          postgres    false            ?            1259    34230 '   vw_creacion_masiva_individaul_catalogos    VIEW     ?   CREATE VIEW public.vw_creacion_masiva_individaul_catalogos AS
 SELECT 1 AS id,
    'INDIVIDUAL'::text AS individual_masiva,
    1 AS status
UNION
 SELECT 0 AS id,
    'MASIVA'::text AS individual_masiva,
    1 AS status;
 :   DROP VIEW public.vw_creacion_masiva_individaul_catalogos;
       public          postgres    false            ?            1259    34239    vw_ingresos_tipo_calculo    VIEW     {  CREATE VIEW public.vw_ingresos_tipo_calculo AS
 SELECT 1 AS tipo_calculo,
    '1 Calculado en base a tabla'::text AS desc_tipo_calculo,
    1 AS status
UNION
 SELECT 2 AS tipo_calculo,
    '2 Calculado en base a padrón'::text AS desc_tipo_calculo,
    1 AS status
UNION
 SELECT 3 AS tipo_calculo,
    '3 Monto capturado por usuario'::text AS desc_tipo_calculo,
    1 AS status;
 +   DROP VIEW public.vw_ingresos_tipo_calculo;
       public          postgres    false            ?            1259    34257    vw_si_no_catalogos    VIEW     ?   CREATE VIEW public.vw_si_no_catalogos AS
 SELECT 1 AS id,
    'SI'::text AS si_no,
    1 AS status
UNION
 SELECT 0 AS id,
    'NO'::text AS si_no,
    1 AS status;
 %   DROP VIEW public.vw_si_no_catalogos;
       public          postgres    false            ?            1259    34265    vw_status_registro    VIEW     ?   CREATE VIEW public.vw_status_registro AS
 SELECT 1 AS id_status,
    'Activo'::text AS desc_status,
    1 AS status
UNION
 SELECT 0 AS id_status,
    'Inactivo'::text AS desc_status,
    1 AS status;
 %   DROP VIEW public.vw_status_registro;
       public          postgres    false            1           2604    35173     books_purchases id_book_purchase    DEFAULT     ?   ALTER TABLE ONLY public.books_purchases ALTER COLUMN id_book_purchase SET DEFAULT nextval('public.books_purchases_id_book_purchase_seq'::regclass);
 O   ALTER TABLE public.books_purchases ALTER COLUMN id_book_purchase DROP DEFAULT;
       public          postgres    false    222    221    222            .           2604    35129    properties id_properties    DEFAULT     ?   ALTER TABLE ONLY public.properties ALTER COLUMN id_properties SET DEFAULT nextval('public.properties_id_properties_seq'::regclass);
 G   ALTER TABLE public.properties ALTER COLUMN id_properties DROP DEFAULT;
       public          postgres    false    216    215    216            /           2604    35140    purchases id_purchases    DEFAULT     ?   ALTER TABLE ONLY public.purchases ALTER COLUMN id_purchases SET DEFAULT nextval('public.purchases_id_purchases_seq'::regclass);
 E   ALTER TABLE public.purchases ALTER COLUMN id_purchases DROP DEFAULT;
       public          postgres    false    217    218    218            0           2604    35160    users id_user    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN id_user SET DEFAULT nextval('public.users_id_user_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN id_user DROP DEFAULT;
       public          postgres    false    220    219    220            ?          0    35170    books_purchases 
   TABLE DATA           {   COPY public.books_purchases (id_book_purchase, id_property, total_bricks, create_date, expiration_date, valid) FROM stdin;
    public          postgres    false    222   k?      ?          0    35126 
   properties 
   TABLE DATA           ?   COPY public.properties (id_properties, name, type, city, risk_level, delivery_estimated_date, proyect_status, total_bricks, available_bricks, price_brick, estimated_rent_year, image, bricks_to_buy) FROM stdin;
    public          postgres    false    216   ??      ?          0    35137 	   purchases 
   TABLE DATA           ~   COPY public.purchases (id_purchases, id_properties, id_user, total, total_bricks, id_authorization, date, status) FROM stdin;
    public          postgres    false    218   ޥ      ?          0    35157    users 
   TABLE DATA           G   COPY public.users (id_user, username, password, create_at) FROM stdin;
    public          postgres    false    220   ??      ?           0    0 $   books_purchases_id_book_purchase_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.books_purchases_id_book_purchase_seq', 1, false);
          public          postgres    false    221            ?           0    0 '   cat_ingresos_clase_id_clase_ingreso_seq    SEQUENCE SET     X   SELECT pg_catalog.setval('public.cat_ingresos_clase_id_clase_ingreso_seq', 1948, true);
          public          postgres    false    203            ?           0    0 &   catrastral_base_id_catrastral_base_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public.catrastral_base_id_catrastral_base_seq', 156320, true);
          public          postgres    false    204            ?           0    0 2   catrastral_kardex_det_id_catrastral_kardex_det_seq    SEQUENCE SET     d   SELECT pg_catalog.setval('public.catrastral_kardex_det_id_catrastral_kardex_det_seq', 91529, true);
          public          postgres    false    205            ?           0    0    id_banco_pk_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.id_banco_pk_seq', 52, true);
          public          postgres    false    202            ?           0    0    id_tarjeta_pk_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.id_tarjeta_pk_seq', 253, true);
          public          postgres    false    206            ?           0    0    properties_id_properties_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.properties_id_properties_seq', 1, false);
          public          postgres    false    215            ?           0    0    purchases_id_purchases_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.purchases_id_purchases_seq', 1, false);
          public          postgres    false    217            ?           0    0    users_id_user_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_id_user_seq', 1, true);
          public          postgres    false    219            ;           2606    35175 "   books_purchases books_purchases_pk 
   CONSTRAINT     n   ALTER TABLE ONLY public.books_purchases
    ADD CONSTRAINT books_purchases_pk PRIMARY KEY (id_book_purchase);
 L   ALTER TABLE ONLY public.books_purchases DROP CONSTRAINT books_purchases_pk;
       public            postgres    false    222            3           2606    35134    properties properties_pk 
   CONSTRAINT     a   ALTER TABLE ONLY public.properties
    ADD CONSTRAINT properties_pk PRIMARY KEY (id_properties);
 B   ALTER TABLE ONLY public.properties DROP CONSTRAINT properties_pk;
       public            postgres    false    216            5           2606    35145    purchases purchases_pk 
   CONSTRAINT     ^   ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_pk PRIMARY KEY (id_purchases);
 @   ALTER TABLE ONLY public.purchases DROP CONSTRAINT purchases_pk;
       public            postgres    false    218            7           2606    35165    users users_pk 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id_user);
 8   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pk;
       public            postgres    false    220            9           2606    35167    users users_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public            postgres    false    220            ?      x?????? ? ?      ?   F  x???Mo?@???+?D??|?MH??6?*i?4?P\?Fa?b[?}Q???`??λs?'?`?&?<M?)?F7?h??-??u?x?d#??(?? ?`&M??v?wUS?}?J6??8???ϲ뤺??j?B?R???2?fkɲ?eٌ3N???8?Ɛ?_R?ٮk?~^?B)=W~W?{????O???????d?S??e??Z?3D?j?o??p??V???? ?!??I<?s??h?p?u)?HB(??}.??$??k4BI<?<N??????&?7N?n?XՕ*?ꤠ?`3??:?Oǈ}???{޹bȮR|????ӭ??      ?      x?????? ? ?      ?   :   x?3??J,?/J?LL???342?4202?50?54U0??22?21?33??50?????? I/5     