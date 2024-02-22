from python import Python

fn performace_comparison() raises:
        
    let time = Python.import_module("time")

    var start_time = time.time()

    var total = 0
    for i in range(1, 10000):
        for j in range(1, 10000):
            total += i + j

    print("The result is {total}")

    var end_time = time.time()
    var time_taken = end_time - start_time
    print(time_taken)

    # start_time = time.time()
    # total = sum(i + j for i in range(1, 10000) for j in range(1, 10000))
    # print("The result is {total}")

    # end_time = time.time()
    # print("It took {end_time-start_time:.2f} seconds to compute")

    # start_time = time.time()
    # total = sum(i + j for i in range(1, 10000) for j in range(1, 10000))
    # print("The result is {total}")
    # end_time = time.time()
    #print("It took {end_time-start_time:.2f} seconds to compute")

fn main() raises:
    performace_comparison()
