# [System] Backend設計 - Evaluation Service

# B. サーバー側設計（Speech Evaluation Service）

サーバーは **1つのUseCase中心**で構成します。

***

# B-1. サービス構造

```
API Layer
    ↓
Evaluation UseCase
    ↓
Speech Analyzer
    ↓
Score Calculator
    ↓
Advice Generator
```

***

# B-2. ドメインモデル

サーバーでも同じ概念を使います。

```
Prompt
FitScore
FitAdvice
EvaluationResult
```

***

# B-3. Evaluation UseCase

```
class EvaluateSpeechUseCase:

    def __init__(
        self,
        prompt_repository,
        speech_analyzer,
        score_calculator,
        advice_generator
    ):
        self.prompt_repository = prompt_repository
        self.speech_analyzer = speech_analyzer
        self.score_calculator = score_calculator
        self.advice_generator = advice_generator

    def execute(self, audio_file, prompt_id):

        prompt = self.prompt_repository.get(prompt_id)

        analysis = self.speech_analyzer.analyze(
            audio_file,
            prompt
        )

        score = self.score_calculator.calculate(
            analysis
        )

        advice = self.advice_generator.generate(
            analysis,
            score,
            prompt
        )

        return EvaluationResult(
            prompt=prompt,
            score=score,
            advice=advice
        )
```

***

# B-4. Speech Analyzer

役割

```
音声 → 特徴量
```

処理

```
speech recognition
embedding extraction
prosody features
```

***

# B-5. Score Calculator

```
analysis
 ↓
rhythm score
stress score
clarity score
```

```
overall = (
    0.35 * rhythm +
    0.35 * stress +
    0.30 * clarity
)
```

***

# B-6. Advice Generator

シンプルなルール

```
min(score)
↓
template advice
```

例

```
stress → "Try stressing the word report."
```

***

# B-7. API Controller

```
@app.post("/v1/speech/evaluations")
def evaluate_speech():

    audio = request.files["audioFile"]
    prompt_id = request.form["promptId"]

    result = usecase.execute(audio, prompt_id)

    return result.to_json()
```

***

# C. 全体アーキテクチャ

```
iOS / Android
     ↓
SpeechEvaluationRepository
     ↓
HTTP API
     ↓
Evaluation Service
     ↓
Speech Analyzer
     ↓
Score + Advice
```

***

# ここまでで完成した設計

モバイル

```
ViewModel
UseCase
Repository
Entity
```

サーバー

```
API
UseCase
Analyzer
Score
Advice
```

***

# 次にやるべきこと（重要）

ここまでで **Accent Fit の設計の90%** ができています。

次にやるべきはこれです。

**Prompt設計の次のレベル**

つまり

```
Prompt selection algorithm
```

です。

これは

```
どのお題を出すか
```

を決めるロジックで、  
**学習体験をかなり左右します。**

希望があれば次にこれを設計します。
