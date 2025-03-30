package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestHandleRequest(t *testing.T) {
	t.Run("ValidEvent", func(t *testing.T) {
		event := Event{"Hello"}

		data, err := handleRequest(event)

		assert.Nil(t, err)

		assert.Equal(t, data.Message, "hello")
	})

	t.Run("InvalidEvent", func(t *testing.T) {
		event := Event{}

		_, err := handleRequest(event)

		assert.Error(t, err)
	})
}
