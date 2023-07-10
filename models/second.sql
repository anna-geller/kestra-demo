select *
from {{ ref('first') }}
where id = 1
