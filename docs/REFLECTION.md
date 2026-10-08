# Reflection

## What does GOTO do and what did A3 teach me?

GOTO makes the program jump straight to a label like `<<label>>`. In A1 and A2 I used it to skip to the part of the code I wanted. A3 taught me that you can't jump into an IF block from outside. Oracle gives `PLS-00375: illegal GOTO`. The label has to be in the same block or an outer one, so I moved it out of the IF to fix it.

## Why do people avoid GOTO?

The code jumps all over the place, so it is harder to read and to fix. When I did A4 with IF / ELSIF it read top to bottom and was way easier to follow than A1 and A2.

## What are functions and how did I use them in B5?

A function takes some input and gives back one value. In B5 I put them inside a SELECT, so every row showed the department name, annual salary, years of service and tax without me working them out by hand.

## How did I handle errors in B4 and C1?

B4 catches `NO_DATA_FOUND` and returns `Unknown Department` so it does not crash when the ID does not exist. C1 does the same for an employee that is not found, and it also has a catch for any other error that returns a message.

## What was hard for me?

Mostly getting connected in SQL*Plus. I typed `sqlplus` while I was already inside it, and my password had an `@` in it which broke the connection string. After I made a new user it worked. I also had to remember that every block needs the `/` at the end.
