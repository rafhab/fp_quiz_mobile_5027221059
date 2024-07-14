#include <string>
#include <vector>

extern "C" const char* get_question() {
    static std::vector<std::string> questions = {
        "Apa ibu kota Indonesia?",
        "Siapa penemu lampu pijar?",
        "Berapa hasil dari 7 + 8?"
    };
    static int currentIndex = 0;
    currentIndex = (currentIndex + 1) % questions.size();
    return questions[currentIndex].c_str();
}
