class_name TextReccomendation

func get_recc(text, sources = []):
    var score_array = []
    var result = []
    var score = _get_score(text, sources)
    for i in score.keys():
        score_array.push_back({
            "text" : i,
            "score" : score[i]
        })
    
    score_array.sort_custom(
        func(a ,b):
            return a["score"] > b["score"]
    )
     #print(score_array)
    for i in score_array:
        result.push_back(i["text"])
    return result
    
    
func _get_score(text, sources = []):
    var score = {}
    var sorted_result = []
    for source in sources:
        score[source] = 0
        for source_char in source:
            var matched = false
            if source_char.to_lower() in text.to_lower():
                if matched: continue
                score[source] += 1
                matched = true
    
    return score
