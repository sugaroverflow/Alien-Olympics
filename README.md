

Interstellar Olympics is a **multi-player team-based party game** that utilizes sensors built into ordinary objects to play. The game is based on the story of alien versus human olympics - where both races (as teams) compete in hop, toss, and tilt challenges. The game also involves audience intervention. The game is played until a total of six rounds have passed. The team with the most points wins.

This game was **originally designed** for Beyond the Joystick, a graduate class at NYU Engineering taught by game designer and media artist in residence at Game Center, Kaho Abe.

This game is **designed for public spaces**  as it involves a lot of movement and an interactive audience. ProcessingJS is used for the screen and audio experience. The Arduino programming language is used  for connecting the physical interface into the screen. You'll need a bucket with a detachable lid, two piezzo elements, two buttons, a photoresistor sensor, an accelerometer an Arduino UNO, a prototyping board, and a computer.

The **gameplay **was a physical challenge. For each round, either the Human or the Alien team can pick a challenge - Hop, Tilt or Toss. In the Hop challenge, a player is challenge to step on the hop square and jump multiple times. The screen keeps track of the score. After 10 seconds are up, the team with the most hops wins. The Tilt challenge requires teams to tilt the lid on their head without touching it or dropping it for 10 seconds. The Toss requires two team players to toss plastic balls into the bucket. The team with the most tosses wins.

The** audience** can intervene at anytime during the game by hitting the intervention button within their reach. The button pauses the game. In this time, the audience can add any kind of rule to the game (for example, hop while singing the alphabet). If the teams do not adhere the new rule when the game resumes, the audience has the power to press buttons to deduct score.

The **technology** works like this: The Arduino board is hooked by wires to all the sensors. Starting with the audience: the intervention button is a sponge covering a piezzo sensor. The tilt lid has an accelerometer taped on which sends the dimensional data to Arduino. The toss bucket has a photoresistor which measures the amount of light reaching the sensor - when a ball lands in the bucket, the resistor senses the lack of light. This data range allows the game to know a toss has been made. The hop board, like the intervention button, is a piezzo element.

**To setup for play,** the game requires all of the above equipment, as well as setting up the circuit correctly (the circuit diagrams will be provided).

![alt tag](https://github.com/SugarOverflow/Alien-Olympics/blob/master/thegame.PNG)
