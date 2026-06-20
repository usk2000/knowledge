# [Product] Shot context for LLM

# Product

```
Project: Accent Fit

Accent Fit is a pronunciation training app for Japanese learners.

Concept:
10-second pronunciation training.

Learning loop:
Prompt → Speak → Score → Improve.

Goal:
Make pronunciation practice short and habitual.

Core UX:
Instant start
Immediate feedback
Daily practice

Key feature:
Personal Pronunciation Map showing pronunciation weaknesses.

Target users:
Busy Japanese professionals.
```

# AI System

```
Project: Accent Fit AI system

Accent Fit evaluates English pronunciation for Japanese learners.

Input:
User recorded audio + prompt text.

Output:
Overall pronunciation score
Category scores
Advice
Pronunciation Map update.

Main categories:
Stress
Rhythm
Clarity
R/L
TH

AI components:
Speech evaluation pipeline
Pronunciation Map
Recommendation engine
Prompt dataset.
```

# Engineering

```
Project: Accent Fit architecture

Mobile:
iOS SwiftUI
Android Kotlin

Backend:
Python FastAPI

Speech AI:
Whisper
wav2vec2

Database:
Firestore

Main entities:
Prompt
SpeechSession
UserProfile

Main services:
Speech evaluation
Recommendation engine
Prompt delivery
Session storage
```