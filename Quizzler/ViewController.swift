
import UIKit

class ViewController: UIViewController {
    
    //instance variables
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionIndex = 0
    var score: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2{
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionIndex += 1
        
        nextQuestion()
        
    }
    
    func updateUI() {
        
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionIndex + 1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionIndex + 1)
        
    }
    
    func nextQuestion() {
        if questionIndex < allQuestions.list.count {
            questionLabel.text = allQuestions.list[questionIndex].questionText
            updateUI()
        } else {
            
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to start over ?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) {
                (UIAlertAction) in
                self.startOver()
            }
            alert.addAction(restartAction)
            present(alert, animated: false, completion: nil)
        }
    }
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionIndex].answer
        if correctAnswer == pickedAnswer {
            ProgressHUD.showSuccess("Correct")
            score += 1
        } else {
            ProgressHUD.showError("Wrong!")
        }
    }
    
    func startOver() {
        questionIndex = 0
        score = 0
        nextQuestion()
    }
    
}
