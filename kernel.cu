#include <thrust/scan.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>

int main()
{
    bool failed = false;
    for (int i = 1; i <= std::numeric_limits<uint32_t>::max(); ++i)
    {
        thrust::host_vector<uint32_t> temp(i, 1);

        thrust::device_vector<uint32_t> d0 = temp;
        thrust::device_vector<uint32_t> result(d0.size(), 0);

        thrust::inclusive_scan(d0.begin(), d0.end(), result.begin());

        if (result.back() != i)
        {
            if (failed)
                continue;

            std::cout << "at iteration: " << i << "; " << result.back() << " != " << i << std::endl;

            std::cout << "[" << i << " - ";
            failed = true;
        }
        else if (failed)
        {
            std::cout << i << "]\n";
            failed = false;
        }
    }
    return 0;
}