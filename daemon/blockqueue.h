#include <mutex>
#include <queue>

template <class T>
class MQueue {
public:
  void push(T a) {
    std::lock_guard<std::mutex> lock(mutex);
    data.push(a);
  }

  bool empty() {
    return data.empty();
  }

  T peek() {
    std::lock_guard<std::mutex> lock(mutex);
    return data.front();
  }

  T pop() {
    std::lock_guard<std::mutex> lock(mutex);
    T ret = data.front();
    data.pop();
    return ret;
  }

private:
  std::queue<T> data;
  std::mutex mutex;
};
