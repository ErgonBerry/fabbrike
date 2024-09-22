package utils

import "os"

// Verifica se um arquivo existe
func FileExists(filename string) bool {
    _, err := os.Stat(filename)
    return !os.IsNotExist(err)
}
