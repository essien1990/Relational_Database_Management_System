-- create a new table
CREATE​ ​ TABLE​ stackoverflow.​ "questions"​ (
"id"​ int4 ​ NOT​ ​ NULL​ ,
"user_id"​ int4 ​ NOT​ ​ NULL​ ,
"title"​ ​ TEXT​ ​ NOT​ ​ NULL​ ,
"body"​ ​ TEXT​ ​ NOT​ ​ NULL​ ,
"accepted_answer_id"​ int4 ​ NULL​ ,
"score"​ int4 ​ NULL​ ,
"view_count"​ int4 ​ NOT​ ​ NULL​ ​ DEFAULT​ ​ 0 ​ ,
"comment_count"​ int4 ​ NOT​ ​ NULL​ ​ DEFAULT​ ​ 0 ​ ,
"created_at"​ ​ timestamp​ ​ NOT​ ​ NULL​ ,
PRIMARY ​ KEY​ (​ "id"​ )
);