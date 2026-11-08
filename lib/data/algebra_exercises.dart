
import '../screens/exercises/exercise_screen.dart';

const List<ExerciseQuestion> algebraBasicsQuestions = [
  ExerciseQuestion(
    question: 'What is a variable in algebra?',
    options: [
      'A number that never changes',
      'A letter representing a value',
      'A mathematical operation',
      'A type of equation',
    ],
    correctAnswer: 1,
    hint: 'Think about letters such as x and y.',
    explanation:
        'A variable is a symbol, usually a letter, that represents an unknown or changing value.',
  ),
  ExerciseQuestion(
    question: 'Which of these is a constant?',
    options: ['x', 'y', '7', '3a'],
    correctAnswer: 2,
    hint: 'A constant is a fixed number.',
    explanation:
        'The number 7 is a constant because its value does not change.',
  ),
  ExerciseQuestion(
    question: 'In the expression 5x, what is the coefficient?',
    options: ['x', '5', '0', '5x'],
    correctAnswer: 1,
    hint: 'Look at the number multiplying the variable.',
    explanation:
        'The coefficient is 5 because 5 is multiplied by the variable x.',
  ),
  ExerciseQuestion(
    question: 'Which expression means 3 more than x?',
    options: ['3x', 'x - 3', 'x + 3', 'x / 3'],
    correctAnswer: 2,
    hint: 'More than means addition.',
    explanation:
        'Adding 3 to x gives x + 3.',
  ),
  ExerciseQuestion(
    question: 'If x = 4, what is the value of 2x + 3?',
    options: ['7', '8', '11', '14'],
    correctAnswer: 2,
    hint: 'Replace x with 4 before calculating.',
    explanation:
        '2(4) + 3 = 8 + 3 = 11.',
  ),
];
