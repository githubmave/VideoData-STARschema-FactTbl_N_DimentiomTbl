insert into VIDEOSTART_DLT as
select TO_TIMESTAMP(DATETIME,'YYYY-MM-DD"T"HH24:MI:SS.FF3"Z"') as "DATETIME",
CASE WHEN REGEXP_LIKE(upper(TRIM(REGEXP_SUBSTR(VIDEOTITLE,'[^|]+'))), 'IPHONE|ANDROID|IPAD|APP')  THEN TRIM(REGEXP_SUBSTR(VIDEOTITLE,'[^|]+'))
             WHEN REGEXP_LIKE(upper(TRIM(REGEXP_SUBSTR(VIDEOTITLE,'[^|]+'))), 'NEWS' ) THEN 'Desktop'
             ELSE 'Unknown' end as "PLATFORM",
CASE WHEN REGEXP_LIKE(upper(TRIM(REGEXP_SUBSTR(VIDEOTITLE,'[^|]+'))), 'NEWS') then TRIM(REGEXP_SUBSTR(VIDEOTITLE,'[^|]+'))
             ELSE 'Unknown' end as "SITE",
TRIM(REGEXP_SUBSTR(VIDEOTITLE,'[^|]*$')) as "VIDEO"
from videostart_raw
where EVENTS like '%206%'
and regexp_count(VIDEOTITLE, '\|') !=0;

commit;