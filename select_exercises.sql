##Write queries to find the following information.

The name of all albums by Pink Floyd
-SELECT * FROM albums WHERE artist = 'Pink Floyd';
-The Dark Side of The Moon and The Wall

The year Sgt. Pepper's Lonely Hearts Club Band was released
-SELECT release_date FROM albums WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';
-1967

The genre for the album Nevermind
-SELECT genre FROM albums WHERE name = 'Nevermind';
-Grunge, Alternative rock

Which albums were released in the 1990s
-SELECT name FROM albums WHERE release_date BETWEEN 1990 and 1999;
-The bodyguard, jagged little pill, come on over, falling into you, lets talk about love, dangerous, the immaculate collection, titanic, metallica, nevermind, supernatural

Which albums had less than 20 million certified sales
-SELECT name FROM albums WHERE sales < 20;
-grease, bad, sgt pepper, dirty dancing, lets talk about love, dangerous, the immaculate collection, abbey rd, born in the usa, brothers in arms, titanic, nevermind, the wall

All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
-SELECT * FROM albums where genre = 'rock';
- sgt pepper, 1, abbey road, born in the usa, supernatural 